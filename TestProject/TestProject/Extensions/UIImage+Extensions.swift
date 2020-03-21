//
//  UIImage+Extensions.swift
//  TestProject
//
//  Created by Pavan Kumar Valluru on 21.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import UIKit

enum ImageName: String {
    case bookmark_on = "Bookmark_ON_Big"
    case bookmark_off = "Bookmark_OFF_Big"
    case wohnung = "Wohnung"
}

extension UIImage {
    // Instantiates a `UIImage` from the `ImageName` provided
    convenience init(named imageName: ImageName) {
        self.init(named: imageName.rawValue)!
    }
}
