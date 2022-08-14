//
//  DiskCache.swift
//  Cats
//
//  Created by 김태호 on 2022/07/23.
//

import Foundation

/**
 * Replacement of using UserDefault.
 * The app container provides two directories for storing purgeable data:
 *   /tmp
 *   /Library/Caches
 * The system periodically purges these directories, so iCloud Backup excludes them by default.
 **/
final class DiskCache {
    // MARK: - File Directory should be tmp (Temporary Directory)
    static let shared = DiskCache()
    private let fileManager = FileManager.default
    
    private init() { }
    
    private func isWritable(_ dir: URL) -> Bool {
        return fileManager.isWritableFile(atPath: dir.path)
    }
    
    private func isWritable(_ path: String) -> Bool {
        return fileManager.isWritableFile(atPath: path)
    }
    
    private func isReadable(_ dir: URL) -> Bool {
        return fileManager.isReadableFile(atPath: dir.path)
    }
    
    private func isReadable(_ path: String) -> Bool {
        return fileManager.isReadableFile(atPath: path)
    }
    
    public func fileExists(_ dir: URL) -> Bool {
        return fileManager.fileExists(atPath: dir.path)
    }
    
    public func fileExists(_ path: String) -> Bool {
        return fileManager.fileExists(atPath: path)
    }
    
    public func removeData(at dir: URL) {
        do {
            try fileManager.removeItem(atPath: dir.path)
        } catch {
            print(error)
        }
    }
    
    public func removeData(at path: String) {
        print(path)
        do {
            try fileManager.removeItem(atPath: path)
        } catch {
            print(error)
        }
    }
    
    public func writeData(at dir: URL, content: Data?) -> Bool {
        guard let content = content else { return false }
        do {
            try content.write(to: dir)
            return true
        } catch {
            print(error)
        }
        return false
    }
    
    public func readData(_ dir: URL) -> Data? {
        guard let data = try? Data(contentsOf: dir) else {
            print("Cannot read a data")
            return nil
        }
        return data
    }
}
