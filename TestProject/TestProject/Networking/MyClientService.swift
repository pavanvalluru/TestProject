//
//  MyWebService.swift
//  TestProject
//
//  Created by Pavan Kumar Valluru on 20.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

protocol ClientServiceProtocol: AnyObject {
    func getDecodedResponse<T: Decodable>(from endPoint: EndPoint, objectType: T.Type, completion: @escaping (Result<T, Error>) -> Void)
    func getSessionDataTask(from endPoint: EndPoint, callback: @escaping CompleteClosure) -> URLSessionDataTask
}

class MyClientService: NSObject, ClientServiceProtocol {

    private let decoder = JSONDecoder()
    private let httpClient: HTTPClient

    public init(session: URLSession = AppDelegate.isRunningUITest ? MockURLSession() : URLSession.shared) {
        self.httpClient = HTTPClient(session: session)
    }

    func getDecodedResponse<T: Decodable>(from endPoint: EndPoint, objectType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        httpClient.get(request: endPoint.request) { data, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let data = data else {
                Log.error("invalid response from \(String(describing: endPoint.request.url))")
                let error = NSError(domain: "Invalid results!", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }

            do {
                let model = try self.decoder.decode(objectType, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func getSessionDataTask(from endPoint: EndPoint, callback: @escaping CompleteClosure) -> URLSessionDataTask {
        return httpClient.getSessionDataTask(for: endPoint.request, callback: callback)
    }
}
