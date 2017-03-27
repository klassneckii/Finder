//
//  SearchResultsViewTests.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 18/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

import XCTest

class SearchResultsViewTests: XCTestCase {

    let view = SearchResultsViewController()
    let presenter = MockPresenter()

    override func setUp() {
        super.setUp()
        view.output = presenter
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testViewIsReadyCall() {
        // given

        // when
        view.viewDidLoad()

        // then
        XCTAssertTrue(presenter.viewIsReadyDidCall)
    }

    class MockPresenter: SearchResultsViewOutput {
        
        var viewIsReadyDidCall = false
        
        func userTappedSearchButton(with searchString: String) {
            
        }

        func userSwitchedApiModeTo(_ apiMode: ApiMode) {
            
        }

        func viewIsReady() {
            viewIsReadyDidCall = true
        }
    }
}
