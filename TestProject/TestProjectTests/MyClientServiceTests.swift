//
//  MyClientServiceTests.swift
//  TestProjectTests
//
//  Created by Pavan Kumar Valluru on 20.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import XCTest
@testable import TestProject

class MyClientServiceTests: XCTestCase {

    let mockSession = MockURLSession()
    var myClient: MyClientService!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        myClient = MyClientService(session: mockSession)
    }

    func testGetDecodedResponse() {
        let expectedData = "{\"items\":[{\"id\": 1,\"title\": \"Schöne Zweiraumwohnung direkt im Grünen\",\"price\":500,\"location\":{\"address\":\"Bergmannstraße 33, 10961 Berlin\",\"latitude\":52.488886876519175,\"longitude\":13.397688051882763},\"images\":[{\"id\":1,\"url\":\"https://pic1.jpg/ORIG/resize/600x400/format/jpg\"},{\"id\":2,\"url\":\"https://pic2.jpg/ORIG/resize/600x400/format/jpg\"},{\"id\":3,\"url\":\"https://pic3.jpg/ORIG/resize/600x400/format/jpg\"},{\"id\":4,\"url\":\"https://pic4.jpg/ORIG/resize/600x400/format/jpg\"}]}]}".data(using: .utf8)

        mockSession.nextData = expectedData
        myClient.getDecodedResponse(from: .fetch, objectType: ImmoList.self) { result in
            switch result {
            case .success(let val):
                XCTAssertEqual(val.listings.count, 1)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }

}
