//
//  ItunesDataDisplayManagerTests.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 27/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import XCTest

class ItunesDataDisplayManagerTests: XCTestCase {
    
    let factoryMock = ItunesCellViewModelFactoryMock()
    let ddm = ItunesDataDisplayManagerImplementation()
    let delegate = SearchResultsCellDelegateMock()
    
    override func setUp() {
        super.setUp()
        ddm.factory = factoryMock
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatUpdateItunesItemsCallsFactoryMethod() {
        // given
        let items = [ITunesItem]()
        
        // when
        ddm.update(items, cellDelegate: delegate)
        
        // then
        XCTAssertTrue(factoryMock.didViewModelsCalled)
    }
    
    func testThatDDMClearsData() {
        // given
        let viewModel = SearchResultViewModel(heading: "",
                                              body: "",
                                              image: "",
                                              delegate: delegate)
        ddm.viewModels = [viewModel]
        
        // when
        ddm.clear()
        
        // then
        XCTAssertTrue(ddm.viewModels.isEmpty)
    }
    
    // MARK: Mocks
    
    class SearchResultsCellDelegateMock: SearchResultCellDelegate {
        func coverImageViewTapped(coverImageView: UIImageView) {}
    }
    
    class ItunesCellViewModelFactoryMock: ItunesCellViewModelFactory {
        
        var didViewModelsCalled = false
        
        func viewModels(from itunesItems: [ITunesItem],
                        cellDelegate: SearchResultCellDelegate) -> [SearchResultViewModel] {
            didViewModelsCalled = true
            return []

        }
    }
}
