//
//  Image.swift
//  TestProject
//
//  Created by Pavan Kumar Valluru on 20.03.2020.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

struct Image: Codable {
    var uid: Int
    var url: String

    init(uidVal: Int, urlVal: String) {
        uid = uidVal
        url = urlVal
    }

    enum CodingKeys: String, CodingKey {
        case uid = "id"
        case url
    }
}

extension Image: Equatable {
    static func == (lhs: Image, rhs: Image) -> Bool {
        return lhs.uid == rhs.uid
    }
}
