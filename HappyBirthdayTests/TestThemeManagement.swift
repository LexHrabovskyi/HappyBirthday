//
//  TestThemeManagement.swift
//  HappyBirthday
//
//  Created by Александр on 09.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import XCTest
@testable import HappyBirthday

class ThemeManagementTests: XCTestCase {
    
    func testThemeCreation() {
        
        do {
            let elephantTheme = try ThemeSet(theme: .elephant)
            XCTAssertEqual(elephantTheme.theme, Theme.elephant)
        } catch {
            XCTAssert(false)
        }
        
        do {
            let foxTheme = try ThemeSet(theme: .fox)
            XCTAssertEqual(foxTheme.theme, .fox)
        } catch {
            XCTAssert(false)
        }
        
        do {
            let pelicanTheme = try ThemeSet(theme: .pelican)
            XCTAssertEqual(pelicanTheme.theme, .pelican)
        } catch {
            XCTAssert(false)
        }
        
    }
    
}
