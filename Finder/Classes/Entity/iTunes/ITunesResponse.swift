//
//  ITunesResponse.swift
//  Finder
//
//  Created by Dmitrii on 21.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

struct ITunesResponse: ParsedItem {
    let resultCount: Int
    let items: [ITunesItem]
}
