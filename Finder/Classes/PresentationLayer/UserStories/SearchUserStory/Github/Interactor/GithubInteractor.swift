//
//  GithubInteractor.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 26/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

class GithubInteractor: GithubInteractorInput {
    weak var output: GithubInteractorOutput!
    
    var githubService: GithubService!
    
    func obtainSearchResults(by term: String) {
        
        let githubCompletitionClosure: GithubSearchResultResponseThrowable = { [weak self] githubSearchResultResponse in
            guard let strongSelf = self else {
                return
            }
            do {
                let response = try githubSearchResultResponse()
                strongSelf.output.didReceiveGithubItems(response.items)
            } catch let error {
                strongSelf.output.didFail(withError: error)
            }
        }

        let githubSearchConfiguration = GithubSearchServiceConfiguration(term: term)
        githubService.search(with: githubSearchConfiguration, completion: githubCompletitionClosure)
    }
}
