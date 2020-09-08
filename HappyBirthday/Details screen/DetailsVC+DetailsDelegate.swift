//
//  DetailsVC+DetailsDelegate.swift
//  HappyBirthday
//
//  Created by Александр on 07.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit

extension DetailsViewController: DetailsDelegate {
    
    func showError(message: String) {
        
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true)
        
    }
    
    func enableContinueButton() {
        showBirthdayScreenButton.isEnabled = true
        showBirthdayScreenButton.backgroundColor = .systemBlue
    }
    
    func disableContinueButton() {
        showBirthdayScreenButton.isEnabled = false
        showBirthdayScreenButton.backgroundColor = .gray
    }
    
}
