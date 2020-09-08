//
//  DateCalculatorTests.swift
//  HappyBirthdayTests
//
//  Created by Александр on 08.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import XCTest
@testable import HappyBirthday

class DateCalculatorTests: XCTestCase {
    
    var newMillenium: Date = Date()

    override func setUp() {
        super.setUp()
        var dateComponents = DateComponents()
        dateComponents.year = 2000
        dateComponents.month = 1
        dateComponents.day = 1
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.timeZone = TimeZone(secondsFromGMT: 0)
        newMillenium = Calendar.current.date(from: dateComponents)!
    }
    
    func testAgeCalculator() {
        
        var biggerDate = newMillenium.addDay()
        
        let monthIn13Years = 12 * 13
        for monthAdded in 0...monthIn13Years {
            
            let difference = AgeCalculator.calculatePeriod(fromLesserDate: newMillenium, toBiggerDate: biggerDate)
            biggerDate = biggerDate.addMonth()
            XCTAssertNotNil(difference)
            guard let ageDelga = difference else { continue }
            
            if monthAdded < 12 {
                XCTAssertEqual(AgeCount.month(count: monthAdded), ageDelga)
            } else if monthAdded == 18 {
                let fullYears = monthAdded / 12
                XCTAssertEqual(AgeCount.halfAYear(count: fullYears), ageDelga)
            } else {
                let fullYears = monthAdded / 12
                XCTAssertEqual(AgeCount.year(count: fullYears), ageDelga)
            }
            
        }
        
    }
    
    
}

fileprivate extension Date {
    
    func addMonth() -> Date {
        return Calendar.current.date(byAdding: .month, value: 1, to: self)!
    }
    
    func addDay() -> Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
}
