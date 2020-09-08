//
//  DetailsDelegateMOCK.swift
//  HappyBirthdayTests
//
//  Created by Александр on 08.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import XCTest
@testable import HappyBirthday

class DetailsDelegateMOCK: DetailsDelegate {
    
    var errorShowCompletion: ((String) -> Void)?
    var enableButtonCompletion: (() -> Void)?
    var disableButtonCompletion: (() -> Void)?
    
    func showError(message: String) {
        self.errorShowCompletion?(message)
    }
    
    func enableContinueButton() {
        self.enableButtonCompletion?()
    }
    
    func disableContinueButton() {
        self.disableButtonCompletion?()
    }
    
    
    
}
