//
//  ITunesResponseMapper.swift
//  Finder
//
//  Created by Dmitrii on 21.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

private struct Paths {
    static let resultCount = "resultCount"
    static let results = "results"
}

class ITunesResponseMapper: ResponseMapper<ITunesResponse>, ResponseMapperProtocol {
    
    func process(_ obj: AnyObject?) throws -> ITunesResponse {
        return try process(obj, parse: { json in
            let resultCount = json[Paths.resultCount] as? Int
            let arrayMapper = ArrayResponseMapper<ITunesItem>()
            let itunesItemMapper = ITunesItemResponseMapper()
            
            let results = try? arrayMapper.process(json[Paths.results], mapper: itunesItemMapper.process)
            if let resultCount = resultCount, let results = results {
                return ITunesResponse(resultCount: resultCount, items: results)
            }
            return nil
        })
    }
}
