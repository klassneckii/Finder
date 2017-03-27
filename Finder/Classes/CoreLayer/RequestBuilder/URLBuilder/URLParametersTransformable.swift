//
//  URLParametersTransformable.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 20/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

protocol URLParametersTransformable {
    func toDictionary() -> [String: String]
}

extension URLParametersTransformable {
    func stringQuery(fromStringArray array: [String]) -> String {
        var query = array.reduce("") { result, element in
            return result + element + ","
        }
        query.remove(at: query.index(before: query.endIndex))
        
        return query
    }
}
