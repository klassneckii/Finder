//
//  GithubServiceTests.swift
//  Finder
//
//  Created by Dmitrii on 25.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import XCTest

class GithubServiceTests: XCTestCase {
    
    let defaultTimeout = 2.0
    
    let networkClientMock = NetworkClientMock()
    let deserializerMock = DeserializerMock()
    let requestBuilderMock = RequestBuilderMock()
    let mapperMock = GithubResponseMapperMock()
    var service: GithubServiceImplementation!
    
    override func setUp() {
        super.setUp()
        service = GithubServiceImplementation(requestBuilder: requestBuilderMock,
                                              networkClient: networkClientMock,
                                              deserializer: deserializerMock,
                                              mapper: mapperMock)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatServiceCorrectlyTakesDataFromServer() {
        // given
        let testExpectation = expectation(description: "Service completed its job")
        var returnedResult: GithubResponse?
        
        // when
        let completion: GithubSearchResultResponseThrowable = { result in
            returnedResult = try! result()
            testExpectation.fulfill()
        }
        let configuration = GithubSearchServiceConfiguration(term: "cool")
        service.search(with: configuration, completion: completion)
        
        // then
        waitForExpectations(timeout: defaultTimeout) { handler in
            XCTAssertEqual(returnedResult?.resultCount, 2)
            XCTAssertTrue(self.requestBuilderMock.apiMethod! == .githubUserSearch)
            XCTAssertTrue(self.requestBuilderMock.buildCalled)
            XCTAssertTrue(self.networkClientMock.performCalled)
            XCTAssertTrue(self.deserializerMock.deserializeCalled)
            XCTAssertTrue(self.mapperMock.mapCalled)
        }
    }
    
    func testThatServiceExitsWithErrorIfNetworkClientReturnsError() {
        // given
        networkClientMock.shouldThrowError = true
        
        // when
        findSearchError { error in
            XCTAssertTrue(error as! NetworkClientError == NetworkClientError.emptyDataReturned)
            XCTAssertTrue(self.requestBuilderMock.apiMethod! == .githubUserSearch)
            XCTAssertTrue(self.requestBuilderMock.buildCalled)
            XCTAssertTrue(self.networkClientMock.performCalled)
            XCTAssertFalse(self.deserializerMock.deserializeCalled)
            XCTAssertFalse(self.mapperMock.mapCalled)
        }
    }
    
//    func testThatServiceExitsWithErrorIfDeserializerReturnsError() {
//        // given
//        deserializerMock.shouldThrowError = true
//        
//        // when
//        findSearchError { error in
//            XCTAssertTrue(error as! DeserializerErrorMock == DeserializerErrorMock.deserializeError)
//            XCTAssertTrue(self.requestBuilderMock.apiMethod! == .githubUserSearch)
//            XCTAssertTrue(self.requestBuilderMock.buildCalled)
//            XCTAssertTrue(self.networkClientMock.performCalled)
//            XCTAssertTrue(self.deserializerMock.deserializeCalled)
//            XCTAssertFalse(self.mapperMock.mapCalled)
//        }
//    }
    
    func testThatServiceExitsWithErrorIfMapperReturnsError() {
        // given
        mapperMock.shouldThrowError = true
        
        // when
        findSearchError { error in
            XCTAssertTrue(error as! ResponseMapperError == ResponseMapperError.invalid)
            XCTAssertTrue(self.requestBuilderMock.apiMethod! == .githubUserSearch)
            XCTAssertTrue(self.requestBuilderMock.buildCalled)
            XCTAssertTrue(self.networkClientMock.performCalled)
            XCTAssertTrue(self.deserializerMock.deserializeCalled)
            XCTAssertTrue(self.mapperMock.mapCalled)
        }
    }
    
    // MARK: Private methods
    
    private func findSearchError(checkClosure: @escaping (Error) -> ()) {
        // given
        let testExpectation = expectation(description: "Service completed its job")
        var returnedError: Error!
        
        // when
        
        let completion: GithubSearchResultResponseThrowable = { result in
            do {
                _ = try result()
            } catch let error {
                returnedError = error
                testExpectation.fulfill()
            }
        }
        let configuration = GithubSearchServiceConfiguration(term: "cool")
        service.search(with: configuration, completion: completion)
        
        // then
        waitForExpectations(timeout: defaultTimeout) { handler in
            checkClosure(returnedError)
        }
    }
    
    // MARK: Mocks
    
    class NetworkClientMock: NetworkClient {
        var performCalled = false
        var shouldThrowError = false
        
        func perform(request: URLRequest, completion: NetworkClientCompletion?) {
            performCalled = true
            guard !shouldThrowError else {
                completion! { void in
                    throw NetworkClientError.emptyDataReturned
                }
                return
            }
            
            completion! { void in
                return Data()
            }
        }
    }
    
    class DeserializerMock: Deserializer {
        var deserializeCalled = false
        var shouldThrowError = false
        
        func deserialize(data: Data) throws -> Any {
            deserializeCalled = true
            if shouldThrowError {
                throw DeserializerErrorMock.deserializeError
            }
            return [:]
        }
    }
    
    class RequestBuilderMock: RequestBuilder {
        var buildCalled = false
        var apiMethod: NetworkRequestConstants.APIMethodName?
        
        func build(withConfiguration configuration: RequestBuilderConfiguration) throws -> URLRequest {
            buildCalled = true
            apiMethod = configuration.apiMethod
            return URLRequest(url: URL(string: "https://github.com")!)
        }
    }
    
    class GithubResponseMapperMock: GithubResponseMapper {
        var mapCalled = false
        var shouldThrowError = false
        
        override func process(_ obj: AnyObject?) throws -> GithubResponse {
            mapCalled = true
            if shouldThrowError {
                throw ResponseMapperError.invalid
            }
            
            let mockItem = GithubItem(login: "", accountURL: "", avatarPath: "")
            let mockResponse = GithubResponse(resultCount: 2, items: [mockItem, mockItem])
            
            return mockResponse
        }
    }
}
