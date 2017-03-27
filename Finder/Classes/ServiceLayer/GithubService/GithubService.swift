//
//  GithubService.swift
//  Finder
//
//  Created by Dmitrii on 23.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

typealias GithubSearchResultResponseThrowable = (() throws -> GithubResponse) -> ()

protocol GithubService: class {
    func search(with searchConfiguration: GithubSearchServiceConfiguration,
                completion: @escaping GithubSearchResultResponseThrowable)
}
