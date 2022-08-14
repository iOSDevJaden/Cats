//
//  TestDiskCacheManagerTesting.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/13.
//

import XCTest
@testable import Cats

class TestDiskCacheManagerTesting: XCTestCase {
    let diskFileManager = DiskCache.shared
    let fileDirectory = FileManager.default.temporaryDirectory
    
    func test_disk_file_manager_tmp_url_dir_is_writable_return_true() {
        let filePath = fileDirectory
        
        let isWritable = diskFileManager.isWritable(filePath)
        XCTAssertTrue(isWritable)
    }
    
    func test_disk_file_manager_tmp_str_dir_is_writable_return_true() {
        let filePath = fileDirectory
        
        let isWritable = diskFileManager.isWritable(filePath)
        XCTAssertTrue(isWritable)
    }
    
    func test_disk_file_manager_tmp_url_dir_is_readable_return_true() {
        let filePath = fileDirectory
        
        let isReadable = diskFileManager.isReadable(filePath)
        XCTAssertTrue(isReadable)
    }
    
    func test_disk_file_manager_tmp_str_dir_is_readable_return_true() {
        let filePath = fileDirectory.path
        
        let isReadable = diskFileManager.isReadable(filePath)
        XCTAssertTrue(isReadable)
    }
    
    func test_disk_file_manager_tmp_str_dir_wirte_read_data() {
        let dataContent = "Hello world".data(using: .utf8)
        let filePath = fileDirectory.appendingPathComponent("test")
        
        let contentWritten = diskFileManager.writeData(at: filePath, content: dataContent)
        XCTAssertEqual(contentWritten, true)
        
        let contentExists = diskFileManager.fileExists(filePath)
        XCTAssertEqual(contentExists, true)
        
        let content = diskFileManager.readData(filePath)
        XCTAssertNotNil(content)
        
        // MARK: - Remove it because to prevent error
        diskFileManager.removeData(at: filePath.path)
    }
}
