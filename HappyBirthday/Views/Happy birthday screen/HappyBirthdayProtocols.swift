//
//  HappyBirthdayProtocols.swift
//  HappyBirthday
//
//  Created by Александр on 09.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import Foundation

protocol HappyBirthdayModel: class {
    
    var delegate: HappyBirthdayDelegate? { get set }
    var childData: SavedUserData { get }
    func generateRandomTheme()
    func getChildAge() -> AgeCount
    
}

protocol HappyBirthdayDelegate: class {
    
    func update(withTheme: ThemeSet)
    func showError(message: String)
    
}
