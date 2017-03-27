//
//  RequestBuilderAssemblyTests.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 24/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import XCTest
import Dip

class RequestDirectorAssemblyTests: XCTestCase {
    
    var moduleContainer: DependencyContainer!
    
    override func setUp() {
        super.setUp()
        moduleContainer = RequestBuilderAssembly.moduleContainer()
    }
    
    override func tearDown() {
        moduleContainer = nil
        super.tearDown()
    }
    
    func testModuleConfiguration() {
        // when
        let requestDirector: RequestBuilderImplementation? = try? moduleContainer.resolve()
        let urlBuilder = requestDirector?.urlBuilder as? URLBuilderImplementation
        
        // then
        XCTAssertNotNil(requestDirector)
        XCTAssertNotNil(urlBuilder)
    }
}
