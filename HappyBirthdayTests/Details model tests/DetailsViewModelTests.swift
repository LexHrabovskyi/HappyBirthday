//
//  DetailsViewModelTests.swift
//  HappyBirthdayTests
//
//  Created by Александр on 08.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import XCTest
@testable import HappyBirthday

class DetailsViewModelTests: XCTestCase {
    
    var userDefaults: UserDefaults?
    let userDefaultsSuiteName = "TestDefaults"

    override func setUp() {
        super.setUp()
        UserDefaults().removePersistentDomain(forName: userDefaultsSuiteName)
        userDefaults = UserDefaults(suiteName: userDefaultsSuiteName)
    }
    
    func testWorkingWithDelegate() {
        
        let disableButtonExpectation = XCTestExpectation(description: "waiting for disabling button")
        disableButtonExpectation.expectedFulfillmentCount = 2
        let enableButtonExpectation = XCTestExpectation(description: "waiting for button enabling")
        let errorExpactation = XCTestExpectation(description: "waiting for error")
        
        let detailsDelegate = DetailsDelegateMOCK()
        detailsDelegate.errorShowCompletion = { message in
            XCTAssertEqual(message, "Child should be yonger that 13 years old")
            errorExpactation.fulfill()
        }
        
        detailsDelegate.disableButtonCompletion = {
            disableButtonExpectation.fulfill()
        }
        
        detailsDelegate.enableButtonCompletion = {
            enableButtonExpectation.fulfill()
        }
        
        let currentDate = Date()
        let thirteenYearsAgo = Calendar.current.date(byAdding: .year, value: -13, to: currentDate)
        let errorSavedData = SavedUserData(name: "Lex", dateOfBirth: thirteenYearsAgo!, photoData: nil)
        let testedModel = DetailsViewModel()
        testedModel.saveUserData(errorSavedData)
        
        wait(for: [errorExpactation], timeout: 0.1)
        
        let _ = testedModel.getSavedData()
        wait(for: [disableButtonExpectation], timeout: 0.1)
        
        let rightData = SavedUserData(name: "Lex", dateOfBirth: currentDate, photoData: nil)
        testedModel.saveUserData(rightData)
        wait(for: [enableButtonExpectation], timeout: 0.1)
        
        let dataFromModel = testedModel.getSavedData()
        XCTAssertNotNil(dataFromModel)
        guard let loadedData = dataFromModel else { return }
        XCTAssertEqual(loadedData.name, "Lex")
        XCTAssertEqual(loadedData.dateOfBirth, currentDate)
        
        // TODO: save image and compare it's data after
        
    }
    
}
