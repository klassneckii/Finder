//
//  GithubResponseMapper.swift
//  Finder
//
//  Created by Dmitrii on 23.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

private struct Paths {
    static let resultCount = "total_count"
    static let results = "items"
}

class GithubResponseMapper: ResponseMapper<GithubResponse>, ResponseMapperProtocol {
    
    func process(_ obj: AnyObject?) throws -> GithubResponse {
        return try process(obj, parse: { json in
            let resultCount = json[Paths.resultCount] as? Int
            let arrayMapper = ArrayResponseMapper<GithubItem>()
            let githubItemMapper = GithubItemResponseMapper()
            let results = try? arrayMapper.process(json[Paths.results], mapper: githubItemMapper.process)
            if let resultCount = resultCount, let results = results {
                return GithubResponse(resultCount: resultCount, items: results)
            }
            return nil
        })
    }
}
