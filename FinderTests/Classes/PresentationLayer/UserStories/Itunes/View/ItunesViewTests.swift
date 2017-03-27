//
//  ItunesViewTests.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 26/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

import XCTest

class ItunesViewTests: XCTestCase {
    
    var viewController: ItunesViewController!
    let presenter = MockPresenter()
    let tableView = UITableView.init(frame: CGRect.infinite, style: .grouped)
    let ddmMock = DataDisplayManagerMock()
    
    override func setUp() {
        super.setUp()
        viewController = ItunesViewController()
        viewController.output = presenter
        viewController.tableView = tableView
        viewController.dataDisplayManager = ddmMock
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testViewIsReadyCall() {
        // given
        
        // when
        viewController.viewDidLoad()
        
        // then
        XCTAssertTrue(presenter.viewIsReadyDidCall)
    }
    
    func testThatViewControllerSetupCorrectDataSourceAndDelegate() {
        // given
        
        // when
        viewController.viewDidLoad()
        
        // then
        XCTAssertTrue(viewController.tableView!.delegate as! DataDisplayManagerMock == ddmMock)
        XCTAssertTrue(viewController.tableView!.dataSource as! DataDisplayManagerMock == ddmMock)
    }
    
    func testThatViewControllerCallsDataDisplayManagerWhenItemsNotEmpty() {
        // when
        viewController.update(MockGenerator.itunesItems(itemsCount: 10))
        
        // then
        XCTAssertTrue(ddmMock.updateCalled)
    }
    
    func testThatWhenSearchFailedDDMClearCalled() {
        // when
        viewController.searchFailed(description: MockGenerator.searchTerm())
        
        // then
        XCTAssertTrue(ddmMock.clearCalled)
    }
    
    // MARK: Mocks
    
    class DataDisplayManagerMock: NSObject, UITableViewDataSource, ItunesDataDisplayManager {
        
        var updateCalled = false
        var clearCalled = false
        
        func update(_ itunesItems: [ITunesItem],
                    cellDelegate: SearchResultCellDelegate) {
            updateCalled = true
        }
        
        func clear() {
            clearCalled = true
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
    }
    
    class MockPresenter: ItunesViewOutput {
        
        var viewIsReadyDidCall = false
        
        func viewIsReady() {
            viewIsReadyDidCall = true
        }
    }
    
}
