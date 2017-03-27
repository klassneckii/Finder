//
//  RequestBuilder.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 20/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

protocol RequestBuilder {
    /**
     Network request builder protocol.
     
     Parameters:
     - configuration: object, contains all needed resources for request configuration
     
     - Returns: Constructed URL Request
     */
    func build(withConfiguration configuration: RequestBuilderConfiguration) throws -> URLRequest
}
