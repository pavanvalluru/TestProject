//
//  ImageCache.swift
//  TestProject
//
//  Created by Pavan Kumar Valluru on 20.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import UIKit

protocol ImageCachable {
    func image(forKey key: String) -> UIImage?
    func save(image: UIImage, forKey key: String)
}

class ImageCache: ImageCachable {
    private let cache = NSCache<NSString, UIImage>()
    private var observer: NSObjectProtocol!

    static let shared = ImageCache()

    private init() {
        // make sure to purge cache on memory pressure
        observer = NotificationCenter.default.addObserver(forName: .NSBundleResourceRequestLowDiskSpace,
                                                          object: nil, queue: nil) { [weak self] _ in
            self?.releaseMemory()
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(observer!)
    }

    func releaseMemory() {
        // purge cache on memory issue
        cache.removeAllObjects()
    }

    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    func save(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
