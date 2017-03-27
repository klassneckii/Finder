//
//  RequestBuilderConfiguration.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 20/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

struct RequestBuilderConfiguration {
    let apiPath: NetworkRequestConstants.APIPath
    let apiMethod: NetworkRequestConstants.APIMethodName
    
    let urlBuilderConfiguration: URLBuilderConfiguration
    let httpMethod: NetworkRequestConstants.HTTPMethod
}
