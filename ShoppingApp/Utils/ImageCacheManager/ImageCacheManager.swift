//
//  ImageCacheManager.swift
//  ShoppingApp
//
//  Created by Dogukaan Kılıçarslan on 30.09.2022.
//

import UIKit

///A manager to cache and retreive images from cache memory. If this didnt exist, images would take up space in RAM.
class ImageCacheManager {
    private static let imageCache = NSCache<NSString, UIImage>()

    /// Saves and addresses images to the ram
    class func setImagesToCache(object: UIImage, key: String) {
        imageCache.setObject(object, forKey: NSString(string: key))
    }

    /// Load images set to the ram
    class func returnImagesFromCache(key: String) -> UIImage? {
        return imageCache.object(forKey: NSString(string: key))
    }
}
