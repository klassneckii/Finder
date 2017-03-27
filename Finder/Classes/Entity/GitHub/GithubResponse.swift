//
//  GithunResponse.swift
//  Finder
//
//  Created by Dmitrii on 23.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

struct GithubResponse: ParsedItem {
    let resultCount: Int
    let items: [GithubItem]
}
