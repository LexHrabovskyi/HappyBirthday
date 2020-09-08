//
//  AgeCalculator.swift
//  HappyBirthday
//
//  Created by Александр on 08.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import Foundation

class AgeCalculator {
    
    static func calculatePeriod(fromLesserDate lesserDate: Date, toBiggerDate biggerDate: Date) -> AgeCount? {
        
        guard lesserDate < biggerDate
            , let monthDifference = Calendar.current.dateComponents([.month], from: lesserDate, to: biggerDate).month else { return  nil }
        
        switch monthDifference {
        case 0...11:
            return .month(count: monthDifference)
        case 18:
            return .halfAYear(count: 1)
        default:
            let fullYears = monthDifference / 12
            return .year(count: fullYears)
        }
        
    }
    
}
