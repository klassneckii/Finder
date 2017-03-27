//
//  GithubInteractorTests.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 26/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

import XCTest

class GithubInteractorTests: XCTestCase {

    let interactor = GithubInteractor()
    let githubServiceMock = GithubServiceMock()
    let presenterMock = MockPresenter()
    let searchTerm = MockGenerator.searchTerm()
    
    override func setUp() {
        super.setUp()
        interactor.githubService = githubServiceMock
        interactor.output = presenterMock
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatInteractorProvidesSearchResultsFromGithubServiceToPresenter() {
        // when
        interactor.obtainSearchResults(by: searchTerm)
        
        // then
        XCTAssertTrue(githubServiceMock.obtainCalled)
        XCTAssertTrue(presenterMock.didReceiveCalled)
    }
    
    func testThatInteractorProvidesErrorFromGithubServiceToPresenter() {
        // given
        githubServiceMock.obtainShouldReturnError = true
        
        // when
        interactor.obtainSearchResults(by: searchTerm)
        
        // then
        XCTAssertTrue(githubServiceMock.obtainCalled)
        XCTAssertTrue(presenterMock.didFailToReceiveCalled)
    }
    
    // MARK: Mocks
    
    class GithubServiceMock: GithubService {
        
        var obtainCalled = false
        var obtainShouldReturnError = false
        
        func search(with searchConfiguration: GithubSearchServiceConfiguration,
                    completion: @escaping GithubSearchResultResponseThrowable) {
            
            obtainCalled = true
            if obtainShouldReturnError {
                completion {
                    throw MockError.error
                }
            } else {
                completion {
                    return MockGenerator.githubResponse(itemsCount: 10)
                }
            }
        }
    }
    
    class MockPresenter: GithubInteractorOutput {
        
        var didReceiveCalled = false
        var didFailToReceiveCalled = false
        
        func didFail(withError error: Error) {
            didFailToReceiveCalled = true
        }
        
        func didReceiveGithubItems(_ items: [GithubItem]) {
            didReceiveCalled = true
        }

    }
}
