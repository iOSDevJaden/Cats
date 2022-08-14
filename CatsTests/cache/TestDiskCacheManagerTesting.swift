//
//  TestDiskCacheManagerTesting.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/13.
//

import XCTest
@testable import Cats

class DiskCachManager {
    static let shared = DiskCachManager()
    private let fileManager = FileManager.default
    
    private init() { }
    
    func isWritable(_ dir: URL) -> Bool {
        return fileManager.isWritableFile(atPath: dir.path)
    }
    
    func isWritable(_ path: String) -> Bool {
        return fileManager.isWritableFile(atPath: path)
    }
    
    func isReadable(_ dir: URL) -> Bool {
        return fileManager.isReadableFile(atPath: dir.path)
    }
    
    func isReadable(_ path: String) -> Bool {
        return fileManager.isReadableFile(atPath: path)
    }
    
    func fileExists(_ dir: URL) -> Bool {
        return fileManager.fileExists(atPath: dir.path)
    }
    
    func fileExists(_ path: String) -> Bool {
        return fileManager.fileExists(atPath: path)
    }
    
    func removeData(at dir: URL) {
        do {
            try fileManager.removeItem(atPath: dir.path)
        } catch {
            print(error)
        }
    }
    
    func removeData(at path: String) {
        print(path)
        do {
            try fileManager.removeItem(atPath: path)
        } catch {
            print(error)
        }
    }
    
    func writeData(at dir: URL, content: Data?) -> Bool {
        guard let content = content else { return false }
        do {
            try content.write(to: dir)
            return true
        } catch {
            print(error)
        }
        return false
    }
    
    func readData(_ dir: URL) -> Data? {
        guard let data = try? Data(contentsOf: dir) else {
            print("Cannot read a data")
            return nil
        }
        return data
    }
}

class TestDiskCacheManagerTesting: XCTestCase {
    let diskFileManager = DiskCachManager.shared
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
