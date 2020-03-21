//
//  EndPoint.swift
//  TestProject
//
//  Created by Pavan Kumar Valluru on 20.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

enum EndPoint {
    case fetch
    case image(url: URL)

    private var url: URL {
        switch self {
        default:
            return URL(string: "https://pavanvalluru.github.io/sampleServer/listings.json")!
        }
    }

    var request: URLRequest {
        switch self {
        case .image(let url):
            return URLRequest(url: url)
        default:
            let request = URLRequest(url: url)
            return request
        }
    }
}
