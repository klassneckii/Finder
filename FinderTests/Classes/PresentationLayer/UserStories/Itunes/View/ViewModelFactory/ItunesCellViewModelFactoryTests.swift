//
//  ItunesCellViewModelFactoryTests.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 27/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

import XCTest

class ItunesCellViewModelFactoryTests: XCTestCase {
    
    let factory = ItunesCellViewModelFactoryImplementation()
    let delegate = SearchResultsCellDelegateMock()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatFactoryReturnsItunesViewModels() {
        // given
        let items = MockGenerator.itunesItems(itemsCount: 10)
        
        // when
        let viewModels = factory.viewModels(from: items,
                                            cellDelegate: delegate)
        
        // then
        XCTAssertTrue(viewModels.count == items.count)
        for index in 0 ..< items.count {
            XCTAssertTrue(viewModels[index].heading == items[index].title)
            XCTAssertTrue(viewModels[index].body == items[index].author)
            XCTAssertTrue(viewModels[index].image == items[index].cover)
        }
    }
    
    // MARK: Mocks
    
    class SearchResultsCellDelegateMock: SearchResultCellDelegate {
        func coverImageViewTapped(coverImageView: UIImageView) {}
    }
}
