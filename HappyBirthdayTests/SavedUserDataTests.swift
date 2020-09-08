//
//  HappyBirthdayTests.swift
//  HappyBirthdayTests
//
//  Created by Александр on 07.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import XCTest
@testable import HappyBirthday

class SavedUserDataTests: XCTestCase {

    func testExample() throws {
        
        let testDate = Date()
        let dataToSave = SavedUserData(name: "Lex", dateOfBirth: testDate, photoData: nil)
        SavedDataService.save(userData: dataToSave)
        
        let dataFromService = SavedDataService.getUserData()
        XCTAssertNotNil(dataFromService)
        guard let loadedData = dataFromService else { return }
        XCTAssertEqual(loadedData.name, "Lex")
        XCTAssertEqual(loadedData.dateOfBirth, testDate)
        
        // TODO: get one of the pictures, save it and compare too
        
    }

}
