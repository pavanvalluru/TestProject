//
//  HTTPClient.swift
//  TestProject
//
//  Created by Pavan Kumar Valluru on 20.03.20.
//  Copyright © 2018 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

typealias CompleteClosure = (_ data: Data?, _ error: Error?) -> Void

// MARK: HttpClient Implementation
class HTTPClient {

    private let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func get(request: URLRequest, callback: @escaping CompleteClosure) {
        let task = self.getSessionDataTask(for: request, callback: callback)
        task.resume()
    }

    func getSessionDataTask(for request: URLRequest, callback: @escaping CompleteClosure) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { (data, _, error) in
            callback(data, error)
        }
        return task
    }
}
