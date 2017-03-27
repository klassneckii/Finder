//
//  ITunesServiceConfiguration.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 20/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

struct ITunesSearchServiceConfiguration: URLBuilderConfiguration {
    let term: String
}

extension ITunesSearchServiceConfiguration: URLParametersTransformable {
    func toDictionary() -> [String : String] {
        let constants = NetworkRequestConstants.URLFields.ITunes.self
        return [constants.Search.term: term]
    }
}
