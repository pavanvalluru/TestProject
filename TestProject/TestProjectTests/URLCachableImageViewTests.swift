//
//  UITableViewCellURLImageViewTests.swift
//  TestProjectTests
//
//  Created by Pavan Kumar Valluru on 20.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import XCTest
@testable import TestProject

class UITableViewCellURLImageViewTests: XCTestCase {

    var httpClient: HTTPClient!
    let session = MockURLSession()

    override func setUp() {
        super.setUp()
        httpClient = HTTPClient(session: session)
    }

    override func tearDown() {
        ImageCache.shared.releaseMemory()
    }

    func testFetchImageIsEqual() {
        let expectedImage = UIImage(named: "Animal", in: Bundle(for: type(of: self)), compatibleWith: nil)
        let expectedImageData = expectedImage?.pngData()
        session.nextData = expectedImageData

        let imageView = URLCachableImageView()
        let expected = expectation(description: "Waiting for download")
        _ = imageView.fetchImage(fromURLString: "https://mockurl",
                                 usingClientService: MyClientService(session: session),
                                 usingCache: nil) { _ in
            expected.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)

        let actualData = imageView.image?.pngData()
        XCTAssertNotNil(actualData)
        XCTAssertEqual(expectedImageData, actualData)
    }

    func testImageStoredInCache() {
        let expectedImage = UIImage(named: "Animal", in: Bundle(for: type(of: self)), compatibleWith: nil)
        let expectedImageData = expectedImage?.pngData()
        session.nextData = expectedImageData

        let imageView = URLCachableImageView()
        let expected = expectation(description: "Waiting for download")
        _ = imageView.fetchImage(fromURLString: "https://mockurl/imageCacheTest",
                                 usingClientService: MyClientService(session: session),
                                 usingCache: ImageCache.shared) { _ in
            expected.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)

        let imageFromCache = ImageCache.shared.image(forKey: "https://mockurl/imageCacheTest")
        XCTAssertEqual(expectedImageData, imageFromCache?.pngData())
    }

}
