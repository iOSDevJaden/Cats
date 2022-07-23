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
class DiskCache{
    
    static var shared = DiskCache()
    
    private init() { }
    
    private let fileManager = FileManager.default
    
    func setData(data: Data, name: String) {
        let filePath = getFilePath(name: name)
        print("Writing Data to \(filePath)")
        if fileManager.fileExists(atPath: filePath.path) {
            return
        }
        do {
            try data.write(to: filePath)
        } catch (let err) {
            print("Error \(err)")
        }
    }
    
    func getDataFromFile(name: String) -> Data? {
        let filePath = getFilePath(name: name)
        print("Reading Data from \(filePath)")
        if !fileManager.fileExists(atPath: filePath.path) {
            return nil
        }
        guard let data = try? Data(contentsOf: filePath) else {
            return nil
        }
        return data
    }
    
    func isEmptyPath(at path: String) -> Bool {
        print("Checking if file exist at following \n\(path)")
        return fileManager.fileExists(atPath: getFilePath(name: path).path)
    }
    
    func isNotEmptyPath(at path: String) -> Bool {
        return !isEmptyPath(at: path)
    }
    
    private func getFilePath(name: String) -> URL {
        return fileManager.temporaryDirectory.appendingPathComponent(name)
    }
}
