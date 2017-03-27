//
//  GithubAssemblyTests.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 26/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

import XCTest
import Dip
import Dip_UI

class GithubModuleAssemblyTests: XCTestCase {
    
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
        let moduleContainer = GithubAssembly.moduleContainer(collaboratingAssemblies: [servicesContainer])

        // when
        let view = try! moduleContainer.resolve(GithubViewController.self, tag: GithubViewControllerIdentifier) as! GithubViewController
        let presenter: GithubPresenter = view.output as! GithubPresenter
        let interactor: GithubInteractor = presenter.interactor as! GithubInteractor
        let router: GithubRouter = presenter.router as! GithubRouter

        // then
        XCTAssertNotNil(view, "View nil after module configuration")
        XCTAssertNotNil(presenter, "Presenter nil after module configuration")
        XCTAssertNotNil(interactor, "Interactor nil after module configuration")
        XCTAssertNotNil(router, "Router nil after module configuration")

        XCTAssertTrue(presenter === view.output as! GithubPresenter, "Presenter has wrong output")
        XCTAssertTrue(view === presenter.view, "Presenter has wrong view")
        XCTAssertTrue(view === router.transitionHandler, "Router has wrong transitiong handler")
        XCTAssertTrue(interactor === presenter.interactor as! GithubInteractor, "Presenter has wrong interactor")
        XCTAssertTrue(router === presenter.router as! GithubRouter, "Presenter has wrong router")
        XCTAssertTrue(presenter === interactor.output as! GithubPresenter, "Interactor has wrong presenter")
    }
}
