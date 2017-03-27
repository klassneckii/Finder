//
//  URLBuilderTests.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 24/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import XCTest

class URLBuilderTests: XCTestCase {
    
    var urlBuilder: URLBuilderImplementation!
    
    struct ConfigurationMock: URLBuilderConfiguration {}
    
    override func setUp() {
        super.setUp()
        urlBuilder = URLBuilderImplementation()
    }
    
    override func tearDown() {
        urlBuilder = nil
        super.tearDown()
    }
    
    func testThatURLBuilderBuildsCorrectURLFromItunesSearchConfiguration() {
        // given
        let expectedTerm = "unit"
        
        let expectedTermSubstring = "term=\(expectedTerm)"
        
        let configuration = ITunesSearchServiceConfiguration(term: expectedTerm)
        
        let path = NetworkRequestConstants.APIPath.iTunesPath
        let method = NetworkRequestConstants.APIMethodName.itunesSearch
        
        // when
        let url = try! urlBuilder.build(withAPIPath: path,
                                        APIMethod: method,
                                        configuration: configuration)
        
        // then 
        let queryString = url.query!
        XCTAssertTrue(queryString.contains(expectedTermSubstring))
    }
    
    
    func testThatURLBuilderThrowsErrorIfIncorrectConfigurationUsed() {
        // given
        let configuration = ConfigurationMock()
        
        let apiPath = NetworkRequestConstants.APIPath.iTunesPath
        let apiMethod = NetworkRequestConstants.APIMethodName.itunesSearch
        
        // when
        var catchedError: NetworkRequestConstants.RequestBuilderError!
        do {
            let _ = try urlBuilder.build(withAPIPath: apiPath,
                                         APIMethod: apiMethod,
                                         configuration: configuration)
        } catch let error {
            catchedError = error as! NetworkRequestConstants.RequestBuilderError
        }
        
        // then
        XCTAssertTrue(catchedError == .urlConfigurationParserNotImplemented)
    }
}
