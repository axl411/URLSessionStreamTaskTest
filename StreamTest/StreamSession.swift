//
//  StreamSession.swift
//  StreamTest
//
//  Created by Gu Chao on 2018/11/19.
//  Copyright © 2018 linecorp. All rights reserved.
//

import Foundation

class StreamSession {

    let task: URLSessionStreamTask
    let readQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.name = "\(Bundle.main.bundleIdentifier!).StreamSession.read_queue"
        return queue
    }()
    let writeQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.name = "\(Bundle.main.bundleIdentifier!).StreamSession.write_queue"
        return queue
    }()

    init(task: URLSessionStreamTask) {
        if task.state != .suspended {
            assertionFailure("invalid task")
        }
        self.task = task
    }

    func startListensing() {
        task.resume()

        scheduleReading()
    }

    private func scheduleReading() {
        guard task.state == .running else { return }

        let readOp = StreamTaskReadOperation(streamTask: task)
        readOp.completionBlock = { [weak self, weak readOp] in
            guard let `self` = self else { return }

            if let data = readOp?.data {
                if let str = String(data: data, encoding: .utf8) {
                    print("Received: \(str)")
                    self.scheduleWriting()
                }
            }
            else if let error = readOp?.error {
                // TODO: implement back off > reconnect behavior
                print(error)
                self.task.cancel()
            }
            self.scheduleReading()
        }
        readQueue.addOperation(readOp)
    }

    private func scheduleWriting() {
        guard task.state == .running else { return }

        let writeOp = StreamTaskWriteOperation(streamTask: task, dataToWrite: "[ClientACK]".data(using: .utf8)!)
        writeQueue.addOperation(writeOp)
    }

    deinit {
        if task.state == .running {
            assertionFailure("Should cancel the task first")
        }
        task.cancel()
    }
}
