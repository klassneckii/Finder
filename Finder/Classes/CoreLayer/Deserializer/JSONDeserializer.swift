//
//  JSONDeserializer.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 20/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

/** JSON Deserializer */
class JSONDeserializer: Deserializer {

    func deserialize(data: Data) throws -> Any {
        return try JSONSerialization.jsonObject(with: data, options: [])
    }
}
