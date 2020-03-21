//
//  ListingsViewCellViewModelTests.swift
//  TestProjectTests
//
//  Created by Pavan Kumar Valluru on 21.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import XCTest
@testable import TestProject

class ListingsViewCellViewModelTests: XCTestCase {

    var cellViewModel: ListingsViewCellViewModel!

    override func setUp() {
        let item = Listing(uidVal: 0, titleVal: "title", priceVal: 0.0, locationVal: Location(addresVal: "add", latitudeVal: 0.0, longitudeVal: 0.0))
        cellViewModel = ListingsViewCellViewModel(listing: item)
    }

    func testBookmarkTapped() {
        XCTAssertFalse(cellViewModel.listingInfo.isBookmarked)
        cellViewModel.onBookmarkTapped()
        XCTAssertTrue(cellViewModel.listingInfo.isBookmarked)
    }
}
