//
//  AgeCount.swift
//  HappyBirthday
//
//  Created by Александр on 08.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import Foundation

enum AgeCount: Equatable {
    
    case month(count: Int)
    case year(count: Int)
    case halfAYear(count: Int)
    
    #if swift(>=4.1)
    #else
    static func ==(lhs: ViewModel, rhs: ViewModel) -> Bool {
        switch (lhs, rhs) {
        case (let .month(lhsCount), let .month(rhsCount)):
            return lhsCount == rhsCount
        case (let .year(lhsCount), let .year(rhsCount)):
            return lhsCount == rhsCount
        case (let .halfAYear(lhsCount), let .halfAYear(rhsCount)):
            return lhsCount == rhsCount
        default:
            return false
        }
    }
    #endif
    
}

//extension AgeCalculator: Equatable {
//
//
//    #if swift(>=4.1)
//    #else
//    static func == (lhs: AgeCalculator, rhs: AgeCalculator) -> Bool {
//
//        switch (lhs, rhs) {
//        case (let .month(lhsCount), let .month(rhsCont)):
//            return lhsCount == rhsCount
//        default:
//            return false
//        }
//
//    }
//    #endif
//}
