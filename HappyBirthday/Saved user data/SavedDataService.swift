//
//  SavedDataService.swift
//  HappyBirthday
//
//  Created by Александр on 07.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import Foundation

class SavedDataService {
    
    private static let nameKey = "ChildName"
    private static let dateKey = "ChildBirthday"
    private static let photoName = "childPhoto.png"
    private static let dateFormat = "dd/MM/yyyy"
    
    private static let directory: FileManager.SearchPathDirectory = .cachesDirectory
    private static let domainMask: FileManager.SearchPathDomainMask = .userDomainMask
    
    static func getUserData() -> SavedUserData? {
        
        guard let childName = UserDefaults.standard.string(forKey: nameKey) else {
            return nil
        }
        
        guard let childBirthday = UserDefaults.standard.object(forKey: dateKey) as? Date else {
            return nil
        }
        
        let childPhotoData = getImageData()
        
        let savedData = SavedUserData(name: childName, dateOfBirth: childBirthday, photoData: childPhotoData)
        return savedData
        
    }
    
    static func save(userData: SavedUserData) {
        
        UserDefaults.standard.set(userData.name, forKey: nameKey)
        UserDefaults.standard.set(userData.dateOfBirth, forKey: dateKey)
        guard let photoData = userData.photoData else { return }
        saveImageData(photoData)
        
    }
    
    private static func getImageData() -> Data? {
        
        guard let documentDirectory = FileManager.default.urls(for: directory, in: domainMask).first else {
            print("cannot get \(directory) directory with \(domainMask)")
            return nil
        }
        
        let localUrl = documentDirectory.appendingPathComponent(photoName)
        guard FileManager.default.fileExists(atPath: localUrl.path) else { return nil }
        guard let imageData = try? Data(contentsOf: localUrl) else { return nil }
        return imageData
        
        
    }
    
    private static func saveImageData(_ data: Data) {
        
        guard let documentDirectory = FileManager.default.urls(for: directory, in: domainMask).first else {
            print("cannot get \(directory) directory with \(domainMask)")
            return
        }
        
        let localUrl = documentDirectory.appendingPathComponent(photoName)
        
        do {
            try data.write(to: localUrl)
        } catch  {
            print("cannot save image: \(error)")
        }
        
    }
    
}
