//
//  ItunesInteractorInput.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 26/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

import Foundation

protocol ItunesInteractorInput {
    /**
     Get search results
     
     - term: String you want to search
     */
    func obtainSearchResults(by term: String)
}
