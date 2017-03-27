//
//  FinderUITests.swift
//  FinderUITests
//
//  Created by Dmitrii on 18.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import XCTest

class UITestCase: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
