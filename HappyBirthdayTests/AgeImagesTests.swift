//
//  AgeImagesTests.swift
//  HappyBirthdayTests
//
//  Created by Александр on 09.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import XCTest
@testable import HappyBirthday

class AgeImagesTests: XCTestCase {
    
    func testImagesGetting() {
        
        var testSet = [AgeCount]()
        testSet.append(.month(count: 0))
        testSet.append(.halfAYear(count: 1))
        
        for iterator in 1...12 {
            
            testSet.append(.month(count: iterator))
            testSet.append(.year(count: iterator))
            
        }
        
        for testedAge in testSet {
            
            let image = AgeImages.getImage(forAge: testedAge)
            XCTAssertNotNil(image)
            
        }
        
        
    }
    
}
