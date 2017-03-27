//
//  GithubServiceImplementation.swift
//  Finder
//
//  Created by Dmitrii on 23.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

private struct UrlConstants {
    static let apiPath = NetworkRequestConstants.APIPath.gitHubPath
    static let httpMethod = NetworkRequestConstants.HTTPMethod.GET
}

class GithubServiceImplementation: GithubService {
    
    private let serviceQueue = DispatchQueue.global(qos: .utility)
    
    var requestBuilder: RequestBuilder!
    var networkClient: NetworkClient!
    var deserializer: Deserializer!
    var mapper: GithubResponseMapper!
    
    init(requestBuilder: RequestBuilder,
         networkClient: NetworkClient,
         deserializer: Deserializer,
         mapper: GithubResponseMapper) {
        self.requestBuilder = requestBuilder
        self.networkClient = networkClient
        self.deserializer = deserializer
        self.mapper = mapper
    }
    
    func search(with searchConfiguration: GithubSearchServiceConfiguration,
                completion: @escaping GithubSearchResultResponseThrowable) {
        do {
            let requestBuilderConfiguration =
                RequestBuilderConfiguration(apiPath: UrlConstants.apiPath,
                                            apiMethod: NetworkRequestConstants.APIMethodName.githubUserSearch,
                                            urlBuilderConfiguration: searchConfiguration,
                                            httpMethod: UrlConstants.httpMethod)
            
            let urlRequest = try requestBuilder.build(withConfiguration: requestBuilderConfiguration)
            
            performNetworkOperation(with: urlRequest, completion: completion)
        } catch let error {
            completion { throw error }
        }
    }
    
    private func performNetworkOperation(with request: URLRequest,
                                         completion: @escaping GithubSearchResultResponseThrowable) {
        
        let networkClientCompletion: NetworkClientCompletion = { [weak self] result in
            
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.serviceQueue.async {
                do {
                    let response = try result()
//                    var githubResponse: GithubResponse
                    
                    let deserialized = try strongSelf.deserializer.deserialize(data: response) as AnyObject?
                    let githubResponse = try strongSelf.mapper.process(deserialized)
                    DispatchQueue.main.async {
                        completion { return (githubResponse) }
                    }
                    
//                    if let deserialized = try strongSelf.deserializer.deserialize(data: response) as AnyObject? {
//                        githubResponse = try strongSelf.mapper.process(deserialized)
//                        DispatchQueue.main.async {
//                            completion { return (githubResponse) }
//                        }
//                    }
                } catch let error {
                    DispatchQueue.main.async {
                        completion { throw error }
                    }
                }
            }
        }
    
        networkClient.perform(request: request, completion: networkClientCompletion)
    }
}
