//
//  CoreAssembly.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 20/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

protocol ResponseMapperProtocol {
    associatedtype Item
    func process(_ obj: AnyObject?) throws -> Item
}

enum ResponseMapperError: Error {
    case invalid
    case missingAttribute
}

class ResponseMapper<A: ParsedItem> {
    
    func process(_ obj: AnyObject?, parse: (_ json: [String: AnyObject]) -> A?) throws -> A {
        guard let json = obj as? [String: AnyObject] else { throw ResponseMapperError.invalid }
        if let item = parse(json) {
            return item
        } else {
            throw ResponseMapperError.missingAttribute
        }
    }
}
