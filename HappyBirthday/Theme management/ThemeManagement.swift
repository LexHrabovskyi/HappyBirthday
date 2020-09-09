//
//  ThemeManagement.swift
//  HappyBirthday
//
//  Created by Александр on 09.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit

class ThemeManagement {
    
    static func getRandomTheme() throws -> ThemeSet {
        
        let randomThemeNumber = Int.random(in: 0...2)
        let theme = Theme(rawValue: randomThemeNumber) ?? .elephant
        
        do {
            let themeSet = try ThemeSet(theme: theme)
            return themeSet
        } catch {
            throw error
        }
        
    }
    
    static func getMainImage(for theme: Theme) -> UIImage? {
        
        switch theme {
        case .elephant:
            return UIImage(named: "iOS_elephant")
        case .fox:
            return UIImage(named: "iOS_Fox")
        case .pelican:
            return UIImage(named: "iOS_Pelican")
        }
        
    }
    
    static func getPlaceholderImage(for theme: Theme) -> UIImage? {
        
        switch theme {
        case .elephant:
            return UIImage(named: "Default_place_holder_yellow")
        case .fox:
            return UIImage(named: "Default_place_holder_green")
        case .pelican:
            return UIImage(named: "Default_place_holder_blue")
        }
        
    }
    
    static func getCameraImage(for theme: Theme) -> UIImage? {
        
        switch theme {
        case .elephant:
            return UIImage(named: "Camera_icon_yellow")
        case .fox:
            return UIImage(named: "Camera_icon_green")
        case .pelican:
            return UIImage(named: "Camera_icon_blue")
        }
        
    }
    
    static func getBackgroundColor(for theme: Theme) -> UIColor {
        
        switch theme {
        case .elephant:
            return #colorLiteral(red: 0.9734496474, green: 0.9415209293, blue: 0.8449315429, alpha: 1)
        case .fox:
            return #colorLiteral(red: 0.7739747167, green: 0.9104896188, blue: 0.8732107282, alpha: 1)
        case .pelican:
            return #colorLiteral(red: 0.8544556499, green: 0.9436222911, blue: 0.9638695121, alpha: 1)
        }
        
    }
    
    static func getBorderColor(for theme: Theme) -> UIColor {
        
        switch theme {
        case .elephant:
            return #colorLiteral(red: 0.8777415156, green: 0.7052739263, blue: 0.2184866667, alpha: 1)
        case .fox:
            return #colorLiteral(red: 0.4356244802, green: 0.7718915939, blue: 0.6847763062, alpha: 1)
        case .pelican:
            return #colorLiteral(red: 0.5445102453, green: 0.8256097436, blue: 0.8950958848, alpha: 1)
        }
        
    }
    
}
