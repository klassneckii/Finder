//
//  GithubServiceConfiguration.swift
//  Finder
//
//  Created by Dmitrii on 23.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

struct GithubSearchServiceConfiguration: URLBuilderConfiguration {
    let term: String
}

extension GithubSearchServiceConfiguration: URLParametersTransformable {
    func toDictionary() -> [String : String] {
        let constants = NetworkRequestConstants.URLFields.Github.self
        return [constants.Search.term: term]
    }
}
