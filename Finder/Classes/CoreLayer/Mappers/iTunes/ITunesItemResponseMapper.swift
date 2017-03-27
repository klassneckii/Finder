//
//  ITunesItemResponseMapper.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 20/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

private struct Paths {
    static let trackName = "trackName"
    static let artistName = "artistName"
    static let bigArtwork = "artworkUrl100"
}

final class ITunesItemResponseMapper: ResponseMapper<ITunesItem>, ResponseMapperProtocol {
    
    func process(_ obj: AnyObject?) throws -> ITunesItem {
        return try process(obj, parse: { json in
            let title = json[Paths.trackName] as? String
            let author = json[Paths.artistName] as? String
            let cover = json[Paths.bigArtwork] as? String
            return ITunesItem(title: title ?? "",
                              author: author ?? "",
                              cover: cover ?? "")
        })
    }
}
