//
//  ITunesService.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 20/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

typealias ITunesSearchResultResponseThrowable = (() throws -> ITunesResponse) -> ()

protocol ITunesService: class {
    func search(with searchConfiguration: ITunesSearchServiceConfiguration,
                completion: @escaping ITunesSearchResultResponseThrowable)
}
