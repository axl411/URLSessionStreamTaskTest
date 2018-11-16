//
//  StreamManager.swift
//  StreamTest
//
//  Created by Gu Chao on 2018/11/19.
//  Copyright © 2018 linecorp. All rights reserved.
//

import Foundation

class StreamManager: NSObject {
    static let shared = StreamManager()
    var streamSession: StreamSession?

    private override init() {}

    lazy var urlSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        return session
    }()

    func startConnection() {
        streamSession = newStreamSession()
        streamSession?.startListensing()
    }

    private func newStreamSession() -> StreamSession {
        let task = urlSession.streamTask(withHostName: "localhost", port: 1717)
        return StreamSession(task: task)
    }
}

extension StreamManager: URLSessionStreamDelegate {

    // MARK: - URLSessionStreamDelegate

    func urlSession(_ session: URLSession, betterRouteDiscoveredFor streamTask: URLSessionStreamTask) {
        print(#function)
    }

    // MARK: - URLSessionTaskDelegate

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print(#function, error)
    }
}

