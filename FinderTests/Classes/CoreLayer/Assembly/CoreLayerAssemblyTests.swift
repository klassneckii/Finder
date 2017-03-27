//
//  CoreLayerAssemblyTests.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 24/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation
import XCTest
import Dip

class CoreLayerAssemblyTests: XCTestCase {
    
    var moduleContainer: DependencyContainer!
    
    override func setUp() {
        super.setUp()
        moduleContainer = CoreAssembly.moduleContainer()
    }
    
    override func tearDown() {
        moduleContainer = nil
        super.tearDown()
    }
    
    func testModuleConfiguration() {
        // when
        let jsonDeserializer: JSONDeserializer? = try? moduleContainer.resolve()
        let networkClient: NetworkClientImplementation? = try? moduleContainer.resolve()
        
        // then
        XCTAssertNotNil(jsonDeserializer)
        XCTAssertNotNil(networkClient)
    }
}
