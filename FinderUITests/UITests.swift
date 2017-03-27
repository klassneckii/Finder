//
//  UITests.swift
//  Finder
//
//  Created by Dmitrii on 26.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import XCTest

class UITests: UITestCase {

    func testThatServiceSegmentedControlOnScreen() {
        // given
        let itunesButton = app.segmentedControls.buttons["iTunes"]
        let githubButton = app.segmentedControls.buttons["GitHub"]

        // then
        XCTAssertTrue(githubButton.exists)
        XCTAssertTrue(itunesButton.exists)
    }
    
    func testThatSearchBarOnScreenWhenSegmentChanged() {
        // given
        let searchBar = app.searchFields["Enter search term"]
        let githubButton = app.segmentedControls.buttons["GitHub"]
        
        // when
        githubButton.tap()

        // then
        XCTAssertTrue(searchBar.exists)
    }
    
    func testThatTextEnteredInSearchFielCorrectly() {
        // given
        let searchBar = app.searchFields["Enter search term"]
        let searchTerm = "ui"
        
        // when
        searchBar.typeText(searchTerm)
        
        // then
        XCTAssertEqual(searchBar.value as? String, searchTerm)
    }
    
    func testThatTextInSearchFieldCorrectlyDeleted() {
        // given
        let searchBar = app.searchFields["Enter search term"]
        let searchTerm = "ui"
        searchBar.typeText(searchTerm)
        
        // when
        searchBar.buttons["Clear text"].tap()
        
        // then
        let searchValue = searchBar.value as! String
        XCTAssertTrue(searchValue.isEmpty)
    }
    
    func testThatSearchPerformedSuccess() {
        // given
        let searchBar = app.searchFields["Enter search term"]
        let searchTerm = "Ui"
        searchBar.typeText(searchTerm)
        
        // when
        let searchButton = app.keyboards.buttons["Search"]
        searchButton.tap()
        sleep(5)
        

        // then
        let cellQuery = app.tables.cells.containing(.staticText, identifier: searchTerm)
        let cell = cellQuery.children(matching: .staticText)
        let cellElement = cell.element
        XCTAssertTrue(cellElement.exists)
        
    }
}
