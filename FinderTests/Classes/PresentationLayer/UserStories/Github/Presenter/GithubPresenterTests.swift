//
//  GithubPresenterTests.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 26/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

import XCTest

class GithubPresenterTest: XCTestCase {

    let presenter = GithubPresenter()
    let viewMock = MockView()
    let interactorMock = MockInteractor()
    let searchTerm = MockGenerator.searchTerm()

    override func setUp() {
        super.setUp()
        presenter.view = viewMock
        presenter.interactor = interactorMock
    }

    override func tearDown() {
        super.tearDown()
    }

    func testViewIsReadyCallSetupInitialState() {
        // when
        presenter.viewIsReady()

        // then
        XCTAssertTrue(viewMock.setupInitialStateDidCall)
    }
    
    func testThatWhenModuleConfiguringWithSearchTermInteractorCalled() {
        // when 
        presenter.configure(with: searchTerm)
        
        //when
        XCTAssertTrue(interactorMock.didObtainSearchCalled)
    }
    
    func testThatWhenModuleConfiguringWithSearchTermViewNotified() {
        // when
        presenter.configure(with: searchTerm)
        
        //when
        XCTAssertTrue(viewMock.didSearchStartedCalled)
    }
    
    func testThatWhenSearchSuccessViewUpdatedWithResponseItems() {
        // when
        presenter.didReceiveGithubItems(MockGenerator.githubItems(itemsCount: 10))
        
        // then
        XCTAssertTrue(viewMock.didUpdateGithubItemsCalled)
    }
    
    func testThatWhenSearchFailedViewNotified() {
        // when
        presenter.didFail(withError: MockError.error)
        
        // then
        XCTAssertTrue(viewMock.didSearchFailedCalled)
    }
    
    // MARK: Mocks
    class MockInteractor: GithubInteractorInput {
        
        var didObtainSearchCalled = false
        
        func obtainSearchResults(by term: String) {
            didObtainSearchCalled = true
        }
    }

    class MockView: GithubViewInput {

        var setupInitialStateDidCall = false
        var didSearchStartedCalled = false
        var didSearchFailedCalled = false
        var didUpdateGithubItemsCalled = false

        func setupInitialState() {
            setupInitialStateDidCall = true
        }
        
        func searchStarted() {
            didSearchStartedCalled = true
        }
        
        func searchFailed(description: String) {
            didSearchFailedCalled = true
        }
        
        func update(_ githubItems: [GithubItem]) {
            didUpdateGithubItemsCalled = true
        }
    }
}
