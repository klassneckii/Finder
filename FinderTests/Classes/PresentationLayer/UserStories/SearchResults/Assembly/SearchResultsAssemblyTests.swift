//
//  SearchResultsAssemblyTests.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 18/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

import XCTest
import Dip
import Dip_UI

class SearchResultsModuleAssemblyTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testConfigureModuleForViewController() {
        // given
        let requestBuilderContainer = RequestBuilderAssembly.moduleContainer()
        let coreContainer = CoreAssembly.moduleContainer()
        let servicesContainer = ServicesAssembly.moduleContainer(collaboratingAssemblies: [coreContainer, requestBuilderContainer])
        let moduleContainer = SearchResultsAssembly.moduleContainer(collaboratingAssemblies: [servicesContainer])
        
        // when
        let view = try! moduleContainer.resolve(SearchResultsViewController.self, tag: SearchResultsViewControllerIdentifier) as! SearchResultsViewController
        let presenter: SearchResultsPresenter = view.output as! SearchResultsPresenter
        let interactor: SearchResultsInteractor = presenter.interactor as! SearchResultsInteractor
        let router: SearchResultsRouter = presenter.router as! SearchResultsRouter

        // then
        XCTAssertNotNil(view, "View nil after module configuration")
        XCTAssertNotNil(presenter, "Presenter nil after module configuration")
        XCTAssertNotNil(interactor, "Interactor nil after module configuration")
        XCTAssertNotNil(router, "Router nil after module configuration")

        XCTAssertTrue(presenter === view.output as! SearchResultsPresenter, "Presenter has wrong output")
        XCTAssertTrue(view === presenter.view, "Presenter has wrong view")
        XCTAssertTrue(view === router.transitionHandler, "Router has wrong transitiong handler")
        XCTAssertTrue(interactor === presenter.interactor as! SearchResultsInteractor, "Presenter has wrong interactor")
        XCTAssertTrue(router === presenter.router as! SearchResultsRouter, "Presenter has wrong router")
        XCTAssertTrue(presenter === interactor.output as! SearchResultsPresenter, "Interactor has wrong presenter")
    }
}
