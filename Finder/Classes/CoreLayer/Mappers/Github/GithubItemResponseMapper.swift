//
//  GithubItemResponseMapper.swift
//  Finder
//
//  Created by Dmitrii on 23.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

private struct Paths {
    static let login = "login"
    static let htmlURL = "html_url"
    static let avatarURL = "avatar_url"
}

final class GithubItemResponseMapper: ResponseMapper<GithubItem>, ResponseMapperProtocol {
    
    func process(_ obj: AnyObject?) throws -> GithubItem {
        return try process(obj, parse: { json in
            let login = json[Paths.login] as? String
            let accountURL = json[Paths.htmlURL] as? String
            let avatarPath = json[Paths.avatarURL] as? String
            return GithubItem(login: login ?? "",
                              accountURL: accountURL ?? "",
                              avatarPath: avatarPath ?? "")
        })
    }
}
