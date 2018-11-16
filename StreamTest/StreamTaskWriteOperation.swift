//
//  StreamTaskWriteOperation.swift
//  StreamTest
//
//  Created by Gu Chao on 2018/11/19.
//  Copyright © 2018 linecorp. All rights reserved.
//

import Foundation

class StreamTaskWriteOperation: AsyncOperation {

    let streamTask: URLSessionStreamTask
    let dataToWrite: Data
    var error: Error?

    init(streamTask: URLSessionStreamTask, dataToWrite: Data) {
        self.streamTask = streamTask
        self.dataToWrite = dataToWrite
    }

    override func main() {
        streamTask.write(dataToWrite, timeout: 0) { [weak self] error in
            self?.error = error
            self?.finish()
        }
    }
}
