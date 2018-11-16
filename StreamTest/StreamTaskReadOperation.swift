//
//  StreamTaskReadOperation.swift
//  StreamTest
//
//  Created by Gu Chao on 2018/11/19.
//  Copyright © 2018 linecorp. All rights reserved.
//

import Foundation

class StreamTaskReadOperation: AsyncOperation {

    let streamTask: URLSessionStreamTask
    var data: Data?
    var error: Error?

    init(streamTask: URLSessionStreamTask) {
        self.streamTask = streamTask
    }

    override func main() {
        streamTask.readData(ofMinLength: 0, maxLength: 1000, timeout: 0) { [weak self] data, bool, error in
            self?.data = data
            self?.error = error
            self?.finish()
        }
    }
}
