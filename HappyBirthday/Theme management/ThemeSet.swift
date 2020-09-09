//
//  ThemeSet.swift
//  HappyBirthday
//
//  Created by Александр on 09.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import Foundation
import UIKit

struct ThemeSet {
    
    let theme: Theme
    let mainImage: UIImage
    let placeholderImage: UIImage
    let cameraIconImage: UIImage
    let backgroundColor: UIColor
    let circleBordercolor: UIColor
    
    init(theme: Theme) throws {
        
        self.theme = theme
        self.backgroundColor = ThemeManagement.getBackgroundColor(for: theme)
        self.circleBordercolor = ThemeManagement.getBorderColor(for: theme)
        
        guard let mainImage = ThemeManagement.getMainImage(for: theme) else {
            throw ThemeError.cannotLoadMainImage
        }
        self.mainImage = mainImage
        
        guard let placeholderImage = ThemeManagement.getPlaceholderImage(for: theme) else {
            throw ThemeError.cannotLoadPlaceholderImage
        }
        self.placeholderImage = placeholderImage
        
        guard let cameraImage = ThemeManagement.getCameraImage(for: theme) else {
            throw ThemeError.cannotLoadCameraIconImage
        }
        self.cameraIconImage = cameraImage
        
    }
    
}
