//
//  ItunesInteractorTests.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 26/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

import XCTest

class ItunesInteractorTests: XCTestCase {

    let interactor = ItunesInteractor()
    let itunesServiceMock = ItunesServiceMock()
    let presenterMock = MockPresenter()
    let searchTerm = MockGenerator.searchTerm()
    
    override func setUp() {
        super.setUp()
        interactor.iTunesService = itunesServiceMock
        interactor.output = presenterMock
    }

    override func tearDown() {
        super.tearDown()
    }
    
    
    func testThatInteractorProvidesSearchResultsFromItunesServiceToPresenter() {
        // when
        interactor.obtainSearchResults(by: searchTerm)
        
        // then
        XCTAssertTrue(itunesServiceMock.obtainCalled)
        XCTAssertTrue(presenterMock.didReceiveCalled)
    }
    
    func testThatInteractorProvidesErrorFromItunesServiceToPresenter() {
        // given
        itunesServiceMock.obtainShouldReturnError = true
        
        // when
        interactor.obtainSearchResults(by: searchTerm)
        
        // then
        XCTAssertTrue(itunesServiceMock.obtainCalled)
        XCTAssertTrue(presenterMock.didFailToReceiveCalled)
    }
    
    // MARK: Mocks
    
    class ItunesServiceMock: ITunesService {
        
        var obtainCalled = false
        var obtainShouldReturnError = false
        
        func search(with searchConfiguration: ITunesSearchServiceConfiguration,
                    completion: @escaping ITunesSearchResultResponseThrowable) {
            
            obtainCalled = true
            if obtainShouldReturnError {
                completion {
                    throw MockError.error
                }
            } else {
                completion {
                    return MockGenerator.itunesResponse(itemsCount: 10)
                }
            }
        }
    }
    
    class MockPresenter: ItunesInteractorOutput {
        
        var didReceiveCalled = false
        var didFailToReceiveCalled = false
        
        func didFail(withError error: Error) {
            didFailToReceiveCalled = true
        }
        
        func didReceiveITunesItems(_ items: [ITunesItem]) {
            didReceiveCalled = true
        }
    }
}
