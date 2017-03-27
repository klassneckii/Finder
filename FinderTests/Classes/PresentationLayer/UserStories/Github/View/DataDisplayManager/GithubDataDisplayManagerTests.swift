//
//  GithubDataDisplayManagerTests.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 27/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import XCTest

class GithubDataDisplayManagerTests: XCTestCase {
    
    let factoryMock = GithubCellViewModelFactoryMock()
    let ddm = GithubDataDisplayManagerImplementation()
    let delegate = SearchResultsCellDelegateMock()
    
    override func setUp() {
        super.setUp()
        ddm.factory = factoryMock
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testThatUpdateGithubItemsCallsFactoryMethod() {
        // given
        let items = [GithubItem]()
        
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
    
    class GithubCellViewModelFactoryMock: GithubCellViewModelFactory {
        
        var didViewModelsCalled = false
        
        func viewModels(from githubItems: [GithubItem],
                        cellDelegate: SearchResultCellDelegate) -> [SearchResultViewModel] {
            didViewModelsCalled = true
            return []
        }
    }
}
