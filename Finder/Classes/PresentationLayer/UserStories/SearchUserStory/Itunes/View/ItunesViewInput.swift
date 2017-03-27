//
//  ItunesViewInput.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 26/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

protocol ItunesViewInput: class {
    
    /**
     Notifies view about need to setup initial state
     */
    func setupInitialState()
    
    /**
     Pass obtained iTunes search results to view
     
     - parameter itunesItems: Search results from iTunes
     */
    func update(_ itunesItems: [ITunesItem])
    
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
