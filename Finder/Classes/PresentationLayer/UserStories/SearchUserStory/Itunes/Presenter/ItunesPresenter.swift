//
//  ItunesPresenter.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 26/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

class ItunesPresenter: ItunesModuleInput, ItunesViewOutput, ItunesInteractorOutput {

    weak var view: ItunesViewInput!
    var interactor: ItunesInteractorInput!
    var router: ItunesRouterInput!

    func viewIsReady() {
        view.setupInitialState()
    }
    
    func didFail(withError error: Error) {
        view.searchFailed(description: error.localizedDescription)
    }
    
    func didReceiveITunesItems(_ items: [ITunesItem]) {
        view.update(items)
    }
    
    func configure(with searchTerm: String) {
        view.searchStarted()
        interactor.obtainSearchResults(by: searchTerm)
    }
}
