//
//  ListingsViewModelTests.swift
//  TestProjectTests
//
//  Created by Pavan Kumar Valluru on 21.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import XCTest
@testable import TestProject

class ListingsViewModelTests: XCTestCase {

    let mock = MockURLSession()
    var vm: ListingsViewModel!

    let mockData = "{\"items\":[{\"id\": 1,\"title\": \"Schöne Zweiraumwohnung direkt im Grünen\",\"price\":500,\"location\":{\"address\":\"Bergmannstraße 33, 10961 Berlin\",\"latitude\":52.488886876519175,\"longitude\":13.397688051882763},\"images\":[{\"id\":1,\"url\":\"https://pic1.jpg/ORIG/resize/600x400/format/jpg\"},{\"id\":2,\"url\":\"https://pic2.jpg/ORIG/resize/600x400/format/jpg\"},{\"id\":3,\"url\":\"https://pic3.jpg/ORIG/resize/600x400/format/jpg\"},{\"id\":4,\"url\":\"https://pic4.jpg/ORIG/resize/600x400/format/jpg\"}]}]}".data(using: .utf8)

    var fetchStarted = false

    override func setUp() {
        vm = ListingsViewModel(using: MyClientService(session: mock))
        vm.onFetchStart = {
            self.fetchStarted = true
        }
    }

    override func tearDown() {
        fetchStarted = false
    }

    func testStartFetchListings() {
        mock.nextData = mockData

        let expected = expectation(description: "Waiting for download")
        vm.onFetchComplete = {
            expected.fulfill()
        }
        
        vm.startFetchingListings()
        XCTAssertTrue(fetchStarted)

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testStartFetchListingsError() {
        mock.nextError = NSError(domain: "mock error", code: 0, userInfo: nil)

        let expected = expectation(description: "Waiting for download")
        vm.onFetchFailed = { _ in
            expected.fulfill()
        }

        vm.startFetchingListings()
        XCTAssertTrue(fetchStarted)

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testGetTotalNumberOfItemsToShow() {
        mock.nextData = mockData

        let expected = expectation(description: "Waiting for download")
        vm.onFetchComplete = {
            expected.fulfill()
            XCTAssertEqual(self.vm.getTotalNumberOfItemsToShow(), 1)
        }
        vm.startFetchingListings()
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testGetListingForIndex() {
        mock.nextData = mockData

        let expected = expectation(description: "Waiting for download")
        vm.onFetchComplete = {
            expected.fulfill()
            XCTAssertNotNil(self.vm.getListing(for: 0))
            XCTAssertNil(self.vm.getListing(for: 1))
        }
        vm.startFetchingListings()
        waitForExpectations(timeout: 2, handler: nil)
    }
}
