//
//  ITunesServiceImplementation.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 20/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

struct ITunesServiceUrlConstants {
    static let apiPath = NetworkRequestConstants.APIPath.iTunesPath
    static let apiMethod = NetworkRequestConstants.APIMethodName.itunesSearch
    static let httpMethod = NetworkRequestConstants.HTTPMethod.GET
}    

class ITunesServiceImplementation: ITunesService {
    
    private let serviceQueue = DispatchQueue.global(qos: .utility)
    
    var requestBuilder: RequestBuilder!
    var networkClient: NetworkClient!
    var deserializer: Deserializer!
    var mapper: ITunesResponseMapper!
    
    init(requestBuilder: RequestBuilder,
         networkClient: NetworkClient,
         deserializer: Deserializer,
         mapper: ITunesResponseMapper) {
        self.requestBuilder = requestBuilder
        self.networkClient = networkClient
        self.deserializer = deserializer
        self.mapper = mapper
    }
    
    func search(with searchConfiguration: ITunesSearchServiceConfiguration,
                completion: @escaping ITunesSearchResultResponseThrowable) {
        do {
            let requestBuilderConfiguration =
                RequestBuilderConfiguration(apiPath: ITunesServiceUrlConstants.apiPath,
                                            apiMethod: NetworkRequestConstants.APIMethodName.itunesSearch,
                                            urlBuilderConfiguration: searchConfiguration,
                                            httpMethod: ITunesServiceUrlConstants.httpMethod)
            
            let urlRequest = try requestBuilder.build(withConfiguration: requestBuilderConfiguration)
            
            performNetworkOperation(with: urlRequest, completion: completion)
        } catch let error {
            completion { throw error }
        }
    }
    
    private func performNetworkOperation(with request: URLRequest,
                                         completion: @escaping ITunesSearchResultResponseThrowable) {
        
        let networkClientCompletion: NetworkClientCompletion = { [weak self] result in
            
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.serviceQueue.async {
                do {
                    let response = try result()
//                    var itunesResponse: ITunesResponse
                    
                    let deserialized = try strongSelf.deserializer.deserialize(data: response) as AnyObject? 
                    let itunesResponse = try strongSelf.mapper.process(deserialized)
                    DispatchQueue.main.async {
                        completion { return (itunesResponse) }
                    }
                    
                    
                    
//                    if let deserialized = try strongSelf.deserializer.deserialize(data: response) as AnyObject? {
//                        itunesResponse = try strongSelf.mapper.process(deserialized)
//                        DispatchQueue.main.async {
//                            completion { return (itunesResponse) }
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
