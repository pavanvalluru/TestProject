//
//  UIImageview+Extensions.swift
//  TestProject
//
//  Created by Pavan Kumar Valluru on 20.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation
import UIKit

class URLCachableImageView: UIImageView {

    private var currentTask: URLSessionTask?
    private var currentURL: URL?

    func fetchImage(fromURLString urlString: String,
                    usingClientService service: ClientServiceProtocol,
                    usingCache cache: ImageCachable? = nil,
                    completion: ((_ success: Bool) -> Void)? = nil) -> URLSessionTask? {
        guard let url = URL(string: urlString) else {
            completion?(false)
            return nil
        }
        // cancel prior task, if any
        weak var oldTask = currentTask
        currentTask = nil
        oldTask?.cancel()
        // remove existing image
        self.image = nil
        // get image from cache
        if let imageFromCache = cache?.image(forKey: urlString) { // get it from cache if available
            self.image = imageFromCache
            completion?(true)
            return nil
        }
        // download image & cache it
        currentURL = url
        currentTask = service.getSessionDataTask(from: .image(url: url)) { [weak self] data, _ in
            self?.currentTask = nil
            if let imageData = data, let imageToCache = UIImage(data: imageData) {
                cache?.save(image: imageToCache, forKey: urlString)
                if url == self?.currentURL { // update image only if another download has not triggered
                    DispatchQueue.main.async {
                        self?.image = imageToCache
                        completion?(true)
                    }
                }
            } else {
                completion?(false)
            }
        }
        currentTask?.resume()
        return currentTask
    }

    func cancelCurrentFetch() {
        currentTask?.cancel()
    }
}
