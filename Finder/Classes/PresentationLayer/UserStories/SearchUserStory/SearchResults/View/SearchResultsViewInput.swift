//
//  SearchResultsViewInput.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 18/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

protocol SearchResultsViewInput: class {

    /**
     Notifies view about need to setup initial state
     
     - parameter apiMode: initial api service
     */
    func setupInitialStateWithApiMode(_ apiMode: ApiMode)
    
    /**
     Notifies view about need to show iTunes tab
     */
    func showItunesView()
    
    /**
     Notifies view about need to show Github tab
     */
    func showGithubView()
}
