//
//  SearchResultsPresenterTests.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 18/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

import XCTest

class SearchResultsPresenterTest: XCTestCase {

    let presenter = SearchResultsPresenter()
    let viewMock = MockView()
    let routerMock = MockRouter()

    override func setUp() {
        super.setUp()
        presenter.view = viewMock
        presenter.router = routerMock
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testViewIsReadyCallSetupInitialState() {
        // when
        presenter.viewIsReady()
        
        // then
        XCTAssertTrue(viewMock.didSetupInitialStateCalled)
    }

    func testThatWhenUserTappedSearchButtonRouterCalled() {
        // when
        presenter.userTappedSearchButton(with: MockGenerator.searchTerm())
        
        // then
        XCTAssertTrue(routerMock.didShowServicesCalled)
    }
    
    func testThatPresenterShowItunesViewWhenUserChooseIt() {
        // when 
        presenter.userSwitchedApiModeTo(.itunes)
        
        //then 
        XCTAssertTrue(viewMock.didShowItunesViewCalled)
    }
    
    func testThatPresenterShowGithubViewWhenUserChooseIt() {
        // when
        presenter.userSwitchedApiModeTo(.github)
        
        //then
        XCTAssertTrue(viewMock.didShowGithubViewCalled)
    }

    // MARK: Mocks

    class MockRouter: SearchResultsRouterInput {
        
        var didShowServicesCalled = false
        
        func showEmbeddedServices(with searchTerm: String) {
            didShowServicesCalled = true
        }
    }

    class MockView: SearchResultsViewInput {

        var didSetupInitialStateCalled = false
        var didShowGithubViewCalled = false
        var didShowItunesViewCalled = false
        
        func setupInitialStateWithApiMode(_ apiMode: ApiMode) {
            didSetupInitialStateCalled = true
        }

        func showItunesView() {
            didShowItunesViewCalled = true
        }

        func showGithubView() {
            didShowGithubViewCalled = true
        }
    }
}
