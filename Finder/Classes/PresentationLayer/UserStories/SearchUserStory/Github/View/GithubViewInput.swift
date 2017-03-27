//
//  GithubViewInput.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 26/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

protocol GithubViewInput: class {
    
    /**
     Notifies view about need to setup initial state
     */
    func setupInitialState()
    
    /**
     Pass obtained Github search results to view
     
     - parameter githubItems: Search results from Github
     */
    func update(_ githubItems: [GithubItem])
    
    /**
     Notifies about start searching
     */
    func searchStarted()
    
    /**
     Notifies view about failed search
     
     - parameter description: Search failed error description
     */
    func searchFailed(description: String)
}
