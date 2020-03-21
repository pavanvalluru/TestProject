//
//  ImmoList.swift
//  TestProject
//
//  Created by Pavan Kumar Valluru on 20.03.2020.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

struct ImmoList: Codable {

    var listings: [Listing]

    enum CodingKeys: String, CodingKey {
        case listings = "items"
    }
}
