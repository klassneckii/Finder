//
//  URLBuilder.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 20/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

protocol URLBuilderConfiguration {}
protocol URLBuilder {
    func build(withAPIPath path: NetworkRequestConstants.APIPath,
               APIMethod method: NetworkRequestConstants.APIMethodName,
               configuration: URLBuilderConfiguration) throws -> URL
}
