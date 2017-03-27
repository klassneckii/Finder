//
//  RequestBuilderTests.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 24/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import XCTest

class RequestDirectorTests: XCTestCase {
    
    enum RequestDirectorTestConstants {
        static let mockUrl = URL(string: "https://itunes.com")!
    }
    
    class URLBuilderMock: URLBuilder {
        var buildCalled = false
        var shouldThrowError = false
        
        func build(withAPIPath path: NetworkRequestConstants.APIPath,
                   APIMethod method: NetworkRequestConstants.APIMethodName,
                   configuration: URLBuilderConfiguration) throws -> URL {
            buildCalled = true
            
            if shouldThrowError {
                throw NetworkRequestConstants.RequestBuilderError.incorrectUrlPath
            }
            
            return RequestDirectorTestConstants.mockUrl
        }
    }
    
    struct URLBuilderConfigurationMock: URLBuilderConfiguration {}
    
    var urlBuilderMock: URLBuilderMock!
    var requestBuilder: RequestBuilderImplementation!

    let constants = ITunesServiceUrlConstants.self
    
    override func setUp() {
        super.setUp()
        urlBuilderMock = URLBuilderMock()
        requestBuilder = RequestBuilderImplementation(urlBuilder: urlBuilderMock)
    }
    
    override func tearDown() {
        urlBuilderMock = nil
        requestBuilder = nil
        super.tearDown()
    }
    
    func testThatBuilderCorrectlyConstructsRequest() {
        // given
        let configuration = URLBuilderConfigurationMock()
        let requestConfiguration =
            RequestBuilderConfiguration(apiPath: constants.apiPath,
                                        apiMethod: constants.apiMethod,
                                        urlBuilderConfiguration: configuration,
                                        httpMethod: constants.httpMethod)
        // when
        let request = try! requestBuilder.build(withConfiguration: requestConfiguration)
        
        // then
        XCTAssertTrue(urlBuilderMock.buildCalled)
        XCTAssertNotNil(request)
    }
    
    func testThatBuilderReturnsErrorIfURLBuilderRerturnsError() {
        // given
        let configuration = URLBuilderConfigurationMock()
        let requestConfiguration =
            RequestBuilderConfiguration(apiPath: constants.apiPath,
                                        apiMethod: constants.apiMethod,
                                        urlBuilderConfiguration: configuration,
                                        httpMethod: constants.httpMethod)
        urlBuilderMock.shouldThrowError = true
        
        // when
        var returnedError: NetworkRequestConstants.RequestBuilderError!
        do {
            let _ = try requestBuilder.build(withConfiguration: requestConfiguration)
        } catch let error {
            returnedError = error as! NetworkRequestConstants.RequestBuilderError
        }
        
        // then
        XCTAssertTrue(urlBuilderMock.buildCalled)
        XCTAssertTrue(returnedError == .incorrectUrlPath)
    }
}
