//
//  ImageLoader.swift
//  iOS-Test-Blinqpay
//
//  Created by Mark Boleigha on 12/02/2022.
//  Copyright © 2022 Blinqpay. All rights reserved.
//

import Foundation
import UIKit.UIImage
import Signals

public final class ImageLoader {
    public static let shared = ImageLoader()

    private let cache: CacheType
    private lazy var backgroundQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 5
        return queue
    }()

    public init(cache: CacheType = ImageCache()) {
        self.cache = cache
    }
    
    public func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        
        if let image = cache[url] {
            completion(image)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }
        task.resume()
    }
}
