//
//  URLBuilderImplementation.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 20/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

class URLBuilderImplementation: URLBuilder {
    
    let builderError = NetworkRequestConstants.RequestBuilderError.self
    
    // MARK: URL Builder methods
    
    func build(withAPIPath path: NetworkRequestConstants.APIPath,
               APIMethod method: NetworkRequestConstants.APIMethodName,
               configuration: URLBuilderConfiguration) throws -> URL {
        
        let urlString = path.rawValue + method.rawValue
        
        if let parametersTransformable = configuration as? URLParametersTransformable {
            return try url(fromBaseUrlString: urlString, parameters: parametersTransformable.toDictionary())
        } else {
            throw builderError.urlConfigurationParserNotImplemented
        }
    }

    
    private func url(fromBaseUrlString urlString: String, parameters: [String: String]) throws -> URL {
        var urlComponents = URLComponents(string: urlString)
        var queryItems: [URLQueryItem] = []
        
        for (key, value) in parameters {
            let newItem = URLQueryItem(name: key, value: value)
            queryItems.append(newItem)
        }
        urlComponents?.queryItems = queryItems
        guard let url = urlComponents?.url else {
            throw builderError.incorrectUrlPath
        }
        
        return url
    }
}
