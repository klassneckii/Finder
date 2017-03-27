//
//  GithubInteractorInput.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 26/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

import Foundation

protocol GithubInteractorInput {
    /**
     Get search results
     
     - term: String you want to search
     */
    func obtainSearchResults(by term: String)
}
