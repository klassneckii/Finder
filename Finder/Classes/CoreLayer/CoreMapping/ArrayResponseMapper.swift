//
//  CoreAssembly.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 20/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

final class ArrayResponseMapper<A: ParsedItem> {
    
    func process(_ obj: AnyObject?, mapper: ((AnyObject?) throws -> A)) throws -> [A] {
        guard let json = obj as? [[String: AnyObject]] else { throw ResponseMapperError.invalid }
        
        var items = [A]()
        for jsonNode in json {
            let item = try mapper(jsonNode as AnyObject?)
            items.append(item)
        }
        return items
    }
}
