//
//  Deserializer.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 20/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

protocol Deserializer {
    /**
     Deserialization data method.
    
     - Parameter data: Data for deserialization.
    */
    func deserialize(data: Data) throws -> Any
}
