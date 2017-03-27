//
//  GithubPresenter.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 26/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

class GithubPresenter: GithubModuleInput, GithubViewOutput, GithubInteractorOutput {

    weak var view: GithubViewInput!
    var interactor: GithubInteractorInput!
    var router: GithubRouterInput!

    func viewIsReady() {
        view.setupInitialState()
    }
    
    func didReceiveGithubItems(_ items: [GithubItem]) {
        view.update(items)
    }
    
    func didFail(withError error: Error) {
        view.searchFailed(description: error.localizedDescription)
    }
    
    func configure(with searchTerm: String) {
        view.searchStarted()
        interactor.obtainSearchResults(by: searchTerm)
    }
}
