//
//  CacheManager.swift
//  Cats
//
//  Created by 김태호 on 2022/07/17.
//

import Foundation
import UIKit

class CacheManager {
    
    static let  shared = CacheManager()
    
    private init() { }
    
    // NSData -> UIImage
    var imageCache: NSCache<NSString, NSData> = {
        let cache = NSCache<NSString, NSData>()
        
        // limits are imprecise/not strict
        cache.countLimit = 100
        // Approximately 100 MB
        cache.totalCostLimit = 1024 * 1024 * 100 * 8
        return cache
    }()
    
    func add(data: Data, name: String) {
        imageCache.setObject(
            data as NSData,
            forKey: name as NSString
        )
    }
    
    func remove(name: String) {
        imageCache.removeObject(forKey: name as NSString)
    }
    
    func get(name: String) -> Data? {
        if let nsData = imageCache.object(forKey: name as NSString) {
            return Data(referencing: nsData)
        }
        return nil
    }
    
    func flushCache() {
        imageCache.removeAllObjects()
    }
}
