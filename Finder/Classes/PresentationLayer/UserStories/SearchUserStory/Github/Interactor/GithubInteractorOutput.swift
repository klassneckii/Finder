//
//  GithubInteractorOutput.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 26/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

import Foundation

protocol GithubInteractorOutput: class {
    /**
     Pass obtained search results to presenter
     
     - items: Response array of Github items
     */
    func didReceiveGithubItems(_ items: [GithubItem])
    
    /**
     Pass error to presenter
     
     - error: Error object
     */
    func didFail(withError error: Error)
}
