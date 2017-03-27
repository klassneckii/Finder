//
//  ServiceAssemblyTests.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 24/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation
import XCTest
import Dip

class ServiceAssemblyTests: XCTestCase {
    
    var moduleContainer: DependencyContainer!
    var coreContainer: DependencyContainer!
    var requestContainer: DependencyContainer!
    
    override func setUp() {
        super.setUp()
        coreContainer = CoreAssembly.moduleContainer()
        requestContainer = RequestBuilderAssembly.moduleContainer()
        moduleContainer = ServicesAssembly.moduleContainer(collaboratingAssemblies: [coreContainer, requestContainer])
    }
    
    override func tearDown() {
        moduleContainer = nil
        coreContainer = nil
        requestContainer = nil
        super.tearDown()
    }
    
    func testModuleConfiguration() {
        // when
        let itunesService: ITunesServiceImplementation? = try? moduleContainer.resolve()
        let requestBuilder = itunesService?.requestBuilder
        let deserializer = itunesService?.deserializer
        let networkClient = itunesService?.networkClient
        let mapper = itunesService?.mapper

        // then
        XCTAssertNotNil(itunesService)
        XCTAssertNotNil(requestBuilder)
        XCTAssertNotNil(deserializer)
        XCTAssertNotNil(networkClient)
        XCTAssertNotNil(mapper)
    }
}
