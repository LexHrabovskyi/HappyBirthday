//
//  HappyBirthdayViewModel.swift
//  HappyBirthday
//
//  Created by Александр on 09.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import Foundation

class HappyBirthdayViewModel: HappyBirthdayModel {
    
    weak var delegate: HappyBirthdayDelegate?
    var childData: SavedUserData
    
    init(childData: SavedUserData) {
        self.childData = childData
    }
    
    func generateRandomTheme() {
        
        do {
            let themeSet = try ThemeManagement.getRandomTheme()
            delegate?.update(withTheme: themeSet)
        } catch {
            delegate?.showError(message: error.localizedDescription)
        }
        
    }
    
    func getChildAge() -> AgeCount {
        guard let childAge = AgeCalculator.calculatePeriod(fromLesserDate: childData.dateOfBirth, toBiggerDate: Date()) else {
            return .month(count: 0)
        }
        return childAge
    }
    
}
