//
//  ListingsUsecaseTests.swift
//  TestProjectTests
//
//  Created by Pavan Kumar Valluru on 21.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import XCTest
@testable import TestProject

class ListingsUsecaseTests: XCTestCase {

    var useCase: ListingsUseCase!
    let mock = MockURLSession()

    var successExpectation: XCTestExpectation?
    var errorExpectation: XCTestExpectation?

    var fetchCompleted = false
    var fetchFailed = false

    override func setUp() {
        useCase = ListingsUseCase(delegate: self, service: MyClientService(session: mock))
    }

    override func tearDown() {
        successExpectation = nil
        errorExpectation = nil
    }

    func testStartFetchRequest() {
        let expectedData = "{\"items\":[{\"id\": 1,\"title\": \"Schöne Zweiraumwohnung direkt im Grünen\",\"price\":500,\"location\":{\"address\":\"Bergmannstraße 33, 10961 Berlin\",\"latitude\":52.488886876519175,\"longitude\":13.397688051882763},\"images\":[{\"id\":1,\"url\":\"https://pic1.jpg/ORIG/resize/600x400/format/jpg\"},{\"id\":2,\"url\":\"https://pic2.jpg/ORIG/resize/600x400/format/jpg\"},{\"id\":3,\"url\":\"https://pic3.jpg/ORIG/resize/600x400/format/jpg\"},{\"id\":4,\"url\":\"https://pic4.jpg/ORIG/resize/600x400/format/jpg\"}]}]}".data(using: .utf8)
        mock.nextData = expectedData
        successExpectation = expectation(description: "fetch success expectation")
        useCase.startFetchRequest()
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testStartFetchRequestError() {
        mock.nextError = NSError(domain: "mock error", code: 0, userInfo: nil)
        errorExpectation = expectation(description: "fetch error expectation")
        useCase.startFetchRequest()
        waitForExpectations(timeout: 2, handler: nil)
    }
}

extension ListingsUsecaseTests: ListingsUsecaseProtocol {
    func fetchFinished(with result: [Listing]?) {
        XCTAssertNotNil(successExpectation)
        successExpectation?.fulfill()
    }

    func fetchError(error: Error) {
        XCTAssertNotNil(errorExpectation)
        errorExpectation?.fulfill()
    }
}
