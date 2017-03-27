//
//  MockGenerator.swift
//  Finder
//
//  Created by Dmitrii on 26.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

enum MockError: Error {
    case error
}

class MockGenerator {

    static func itunesItems(itemsCount: Int) -> [ITunesItem] {
        let item = ITunesItem(title: "title", author: "author", cover: "cover")
        let items = Array(repeating: item, count: itemsCount)
        return items
    }
    
    static func itunesResponse(itemsCount: Int) -> ITunesResponse {
        let items = itunesItems(itemsCount: itemsCount)
        let itunesResponse = ITunesResponse(resultCount: itemsCount, items: items)
        return itunesResponse
    }
    
    static func githubItems(itemsCount: Int) -> [GithubItem] {
        let item = GithubItem(login: "login", accountURL: "account", avatarPath: "avatar")
        let items = Array(repeating: item, count: itemsCount)
        return items
    }
    
    static func githubResponse(itemsCount: Int) -> GithubResponse {
        let items = githubItems(itemsCount: itemsCount)
        let githubResponse = GithubResponse(resultCount: itemsCount, items: items)
        return githubResponse
    }
    
    static func searchTerm() -> String {
        return "search"
    }
}


