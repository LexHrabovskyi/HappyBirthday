//
//  AgeImages.swift
//  HappyBirthday
//
//  Created by Александр on 09.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit

class AgeImages {
    
    static func getImage(forAge age: AgeCount) -> UIImage? {
        
        switch age {
        case .month(let month):
            return UIImage(named: "\(month)")
        case .halfAYear(let fullYears):
            guard fullYears == 1 else { return nil }
            return UIImage(named: "1_half")
        case .year(let fullYears):
            return UIImage(named: "\(fullYears)")
        }
        
    }
    
}
