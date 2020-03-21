//
//  HTTPClientTests.swift
//  TestProjectTests
//
//  Created by Pavan Kumar Valluru on 20.03.20.
//  Copyright © 2018 Pavan Kumar Valluru. All rights reserved.
//

import XCTest
@testable import TestProject

class HTTPClientTests: XCTestCase {

    var httpClient: HTTPClient!
    let session = MockURLSession()

    override func setUp() {
        super.setUp()
        httpClient = HTTPClient(session: session)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetRequestWithURL() {
        guard let url = URL(string: "https://mockurl") else {
            XCTAssert(false, "Invalid URL string")
            return
        }

        let request = URLRequest(url: url)
        httpClient.get(request: request) { (_, _) in
            // Return data
        }

        XCTAssert(session.lastURL == url)
    }

    func testGetResumeCalled() {
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask

        guard let url = URL(string: "https://mockurl") else {
            XCTAssert(false, "Invalid URL string")
            return
        }

        let request = URLRequest(url: url)
        httpClient.get(request: request) { (_, _) in
            // Return data
        }

        XCTAssert(dataTask.resumeWasCalled)
    }

    func testGetShouldReturnData() {
        let expectedData = "{}".data(using: .utf8)

        session.nextData = expectedData

        var actualData: Data?
        let request = URLRequest(url: URL(string: "http://mockurl")!)
        httpClient.get(request: request) { (data, _) in
            actualData = data
        }
        XCTAssertNotNil(actualData)
    }

}
