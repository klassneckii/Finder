//
//  ItunesAssemblyTests.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 26/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

import XCTest
import Dip
import Dip_UI

class ItunesModuleAssemblyTests: XCTestCase {

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
        let moduleContainer = ItunesAssembly.moduleContainer(collaboratingAssemblies: [servicesContainer])
        
        // when
        let view = try! moduleContainer.resolve(ItunesViewController.self, tag: ItunesViewControllerIdentifier) as! ItunesViewController
        let presenter: ItunesPresenter = view.output as! ItunesPresenter
        let interactor: ItunesInteractor = presenter.interactor as! ItunesInteractor
        let router: ItunesRouter = presenter.router as! ItunesRouter

        // then
        XCTAssertNotNil(view, "View nil after module configuration")
        XCTAssertNotNil(presenter, "Presenter nil after module configuration")
        XCTAssertNotNil(interactor, "Interactor nil after module configuration")
        XCTAssertNotNil(router, "Router nil after module configuration")

        XCTAssertTrue(presenter === view.output as! ItunesPresenter, "Presenter has wrong output")
        XCTAssertTrue(view === presenter.view, "Presenter has wrong view")
        XCTAssertTrue(view === router.transitionHandler, "Router has wrong transitiong handler")
        XCTAssertTrue(interactor === presenter.interactor as! ItunesInteractor, "Presenter has wrong interactor")
        XCTAssertTrue(router === presenter.router as! ItunesRouter, "Presenter has wrong router")
        XCTAssertTrue(presenter === interactor.output as! ItunesPresenter, "Interactor has wrong presenter")
    }
}
