//
//  SearchResultsViewOutput.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 18/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

protocol SearchResultsViewOutput {

    /**
     Notifies that view is ready
     */
    func viewIsReady()
    
    /**
     Notifies view that user switched api service
     
     - parameter apiMode: initial api service
     */
    func userSwitchedApiModeTo(_ apiMode: ApiMode)
    
    /**
     Notifies view that user tapped search button
     
     - parameter searchString: Search term string
     */
    func userTappedSearchButton(with searchString: String)
}
