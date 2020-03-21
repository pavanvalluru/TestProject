//
//  Location.swift
//  TestProject
//
//  Created by Pavan Kumar Valluru on 20.03.2020.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

struct Location: Codable {
    var address: String
    var latitude: Double
    var longitude: Double

    init(addresVal: String, latitudeVal: Double, longitudeVal: Double) {
        address = addresVal
        latitude = latitudeVal
        longitude = longitudeVal
    }
}
