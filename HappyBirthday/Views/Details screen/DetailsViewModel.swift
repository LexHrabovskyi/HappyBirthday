//
//  DetailsViewModel.swift
//  HappyBirthday
//
//  Created by Александр on 07.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import Foundation

class DetailsViewModel: DetailsModel {
    
    weak var delegate: DetailsDelegate?
    private var previousYearError = 999999
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(checkUpdatedData), name: .savedDataDidUpdate, object: nil)
    }
    
    func getSavedData() -> SavedUserData? {
        
        let dataFromService = SavedDataService.getUserData()
        guard let loadedData = dataFromService else {
            delegate?.disableContinueButton()
            return nil
        }
        checkSavedData(loadedData)
        return loadedData
        
    }
    
    func saveUserData(_ dataToSave: SavedUserData) {
        SavedDataService.save(userData: dataToSave)
    }
    
    @objc
    private func checkUpdatedData(notification: Notification) {
        
        guard let savedData = notification.object as? SavedUserData else { return }
        checkSavedData(savedData)
        if let childPhotoData = savedData.photoData {
            delegate?.updateImage(withData: childPhotoData)
        }
        
    }
    
    private func checkSavedData(_ savedData: SavedUserData) {
        
        guard let childAge = AgeCalculator.calculatePeriod(fromLesserDate: savedData.dateOfBirth, toBiggerDate: Date()) else {
            
            delegate?.showError(message: "Wrong date of birth!")
            return
            
        }
        
        switch childAge {
        case .year(let fullYears):
            
            guard fullYears > 12 else {
                delegate?.enableContinueButton()
                return
            }
            
            if fullYears != previousYearError {
                previousYearError = fullYears
                delegate?.showError(message: "Child should be yonger that 13 years old")
            }
            
            delegate?.disableContinueButton()
            
        default:
            delegate?.enableContinueButton()
        }
        
    }
    
}
