//
//  GithubCellViewModelFactoryTests.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 27/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import XCTest

class GithubCellViewModelFactoryTests: XCTestCase {
    
    let factory = GithubCellViewModelFactoryImplementation()
    let delegate = SearchResultsCellDelegateMock()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatFactoryReturnsGithubViewModels() {
        // given
        let items = MockGenerator.githubItems(itemsCount: 10)
        
        // when
        let viewModels = factory.viewModels(from: items,
                                            cellDelegate: delegate)
        
        // then
        XCTAssertTrue(viewModels.count == items.count)
        for index in 0 ..< items.count {
            XCTAssertTrue(viewModels[index].heading == items[index].login)
            XCTAssertTrue(viewModels[index].body == items[index].accountURL)
            XCTAssertTrue(viewModels[index].image == items[index].avatarPath)
        }
    }
    
    // MARK: Mocks
    
    class SearchResultsCellDelegateMock: SearchResultCellDelegate {
        func coverImageViewTapped(coverImageView: UIImageView) {}
    }
}
