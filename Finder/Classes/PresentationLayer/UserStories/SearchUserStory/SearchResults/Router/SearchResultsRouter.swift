//
//  SearchResultsRouter.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 18/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

import UIKit

class SearchResultsRouter: SearchResultsRouterInput {
    
    weak var transitionHandler: SearchResultsViewInput!
    
    func showEmbeddedServices(with searchTerm: String) {
        guard let transitionHandler = transitionHandler as? UIViewController else {
            return
        }
        
        var itunesViewController: ItunesViewController
        var githubViewController: GithubViewController
        
        
        for viewController in transitionHandler.childViewControllers  {
            if let itunesUnwrappedViewController = viewController as? ItunesViewController {
                itunesViewController = itunesUnwrappedViewController
                let itunesOutput = itunesViewController.output as? ItunesModuleInput
                itunesOutput?.configure(with: searchTerm)
            }
            if let githubUnwrappedViewController = viewController as? GithubViewController {
                githubViewController = githubUnwrappedViewController
                let githubOutput = githubViewController.output as? GithubModuleInput
                githubOutput?.configure(with: searchTerm)
            }
        }
    }

}
