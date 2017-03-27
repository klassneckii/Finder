//
//  RequestBuilderImplementation.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 20/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation


class RequestBuilderImplementation: RequestBuilder {
    
    let urlBuilder: URLBuilder
    
    init(urlBuilder: URLBuilder) {
        self.urlBuilder = urlBuilder
    }
    
    // MARK: RequestBuilder protocol methods
    
    func build(withConfiguration configuration: RequestBuilderConfiguration) throws -> URLRequest {
        let url = try urlBuilder.build(withAPIPath: configuration.apiPath,
                                       APIMethod: configuration.apiMethod,
                                       configuration: configuration.urlBuilderConfiguration)
        var request = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 30)
        request.httpMethod = configuration.httpMethod.rawValue
        return request
    }
}
