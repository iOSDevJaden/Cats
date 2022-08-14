//
//  TestCacheManagerTesting.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/13.
//

import XCTest
@testable import Cats

/**
 * MARK: - Cahce Manager is used for saving image data.
 *  To prevent unnecessary network task.
 */
import UIKit

class TestCacheManagerTesting: XCTestCase {
    private let cacheManager = CacheManager.shared
    private let imageDataName = "imageName"
    
    override func tearDown() {
        cacheManager.flushCache()
    }
    
    func test_cachManager_save_image_cache() {
        cacheManager.add(data: getImageData(), name: imageDataName)
       
        let imageData = cacheManager.get(name: imageDataName)
        
        XCTAssertNotNil(imageData)
        XCTAssertEqual(imageData, cacheManager.get(name: imageDataName))
    }

    func test_cachManager_get_image_cache() {
        cacheManager.add(data: getImageData(), name: imageDataName)
       
        let imageData = cacheManager.get(name: imageDataName)
        
        XCTAssertNotNil(imageData)
        XCTAssertEqual(imageData, cacheManager.get(name: imageDataName))
    }
    
    func test_cachManager_remove_image_cache() {
        cacheManager.add(data: getImageData(), name: imageDataName)
       
        let imageData = cacheManager.get(name: imageDataName)
        
        XCTAssertNotNil(imageData)
        cacheManager.remove(name: imageDataName)
        
        let removedImageData = cacheManager.get(name: imageDataName)
        XCTAssertNil(removedImageData)
    }
    
    func test_cachManager_flush_all_image_cache() {
        cacheManager.add(data: getImageData(), name: imageDataName)
       
        let imageData = cacheManager.get(name: imageDataName)
        
        XCTAssertNotNil(imageData)
        cacheManager.flushCache()
        
        let removedImageData = cacheManager.get(name: imageDataName)
        XCTAssertNil(removedImageData)
    }
}

extension TestCacheManagerTesting {
    private func getImageData() -> Data {
        let imageName = "cat-paw"
        guard let imageData = UIImage(named: imageName)?
            .jpegData(compressionQuality: 0.5) else {
            fatalError("check Image name in the bundle")
        }
        return imageData
    }
}
