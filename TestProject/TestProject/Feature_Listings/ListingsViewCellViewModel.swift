//
//  ListingsCellModel.swift
//  TestProject
//
//  Created by Pavan Kumar Valluru on 21.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

class ListingsViewCellViewModel: PersistanceAccessible {

    var listingInfo: Listing

    var isBookmarked: Bool {
        if AppDelegate.isRunningUITest {
            return listingInfo.isBookmarked
        }
        return persistanceHandler.isBookmarkExists(for: listingInfo)
    }

    var listingPriceString: String {
       return " € \(listingInfo.price.cleanValue) "
    }

    init(listing: Listing) {
        listingInfo = listing
    }

    func onBookmarkTapped() {
        listingInfo.isBookmarked.toggle()
        if !AppDelegate.isRunningUITest {
            persistanceHandler.setBookmark(for: listingInfo, to: listingInfo.isBookmarked)
        }
    }
}
