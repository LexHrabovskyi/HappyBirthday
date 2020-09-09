//
//  HappyBirthdayVC+ModelDelegate.swift
//  HappyBirthday
//
//  Created by Александр on 09.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit

extension HappyBirthdayViewController: HappyBirthdayDelegate {
    
    func update(withTheme: ThemeSet) {
        
        backgroundView.backgroundColor = withTheme.backgroundColor
        mainThemeImageView.image = withTheme.mainImage
        
        if let childPhotoData = viewModel.childData.photoData,
            let childPhoto = UIImage(data: childPhotoData) {
            
            childPhotoImageView.image = childPhoto
            
        } else {
            childPhotoImageView.image = withTheme.placeholderImage
        }
        
        childPhotoImageView.layer.borderWidth = 8
        childPhotoImageView.layer.borderColor = withTheme.circleBordercolor.cgColor
        
        cameraIconImageView.image = withTheme.cameraIconImage
        
        
    }
    
    func showError(message: String) {
        // TODO: create alert and show error message
    }
    
}
