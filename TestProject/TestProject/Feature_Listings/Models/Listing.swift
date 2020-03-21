//
//  Listing.swift
//  TestProject
//
//  Created by Pavan Kumar Valluru on 20.03.2020.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

struct Listing: Codable {
    var uid: Int
    var title: String
    var price: Double
    var location: Location
    var images: [Image]?
    var isBookmarked: Bool = false

    enum CodingKeys: String, CodingKey {
        case uid = "id"
        case title
        case price
        case location
        case images
        case isBookmarked
    }

    init(uidVal: Int, titleVal: String, priceVal: Double, locationVal: Location, imagesVal: [Image]? = nil) {
        uid = uidVal
        title = titleVal
        price = priceVal
        location = locationVal
        images = imagesVal
    }

    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uid = try container.decode(Int.self, forKey: .uid)
        title = try container.decode(String.self, forKey: .title)
        price = try container.decode(Double.self, forKey: .price)
        location = try container.decode(Location.self, forKey: .location)
        images = try? container.decode([Image].self, forKey: .images)
    }

}

extension Listing: Equatable {
    static func == (lhs: Listing, rhs: Listing) -> Bool {
        return lhs.uid == rhs.uid
    }
}
