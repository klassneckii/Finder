//
//  ItunesInteractorOutput.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 26/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

import Foundation

protocol ItunesInteractorOutput: class {
    /**
     Pass obtained search results to presenter
     
     - items: Response array of iTunes items
     */
    func didReceiveITunesItems(_ items: [ITunesItem])
    
    /**
     Pass error to presenter
     
     - error: Error object
     */
    func didFail(withError error: Error)
}
