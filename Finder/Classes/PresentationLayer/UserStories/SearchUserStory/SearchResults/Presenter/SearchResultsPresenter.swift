//
//  SearchResultsPresenter.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 18/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

enum ApiMode: Int {
    case itunes
    case github
}

class SearchResultsPresenter: SearchResultsViewOutput, SearchResultsInteractorOutput {

    weak var view: SearchResultsViewInput!
    var interactor: SearchResultsInteractorInput!
    var router: SearchResultsRouterInput!

    var mode: ApiMode!
    
    // MARK: SearchResultsViewOutput
    func viewIsReady() {
        mode = .itunes
        view.setupInitialStateWithApiMode(mode)
    }

    func userSwitchedApiModeTo(_ apiMode: ApiMode) {
        self.mode = apiMode
        switch mode! {
        case .github:
            view.showGithubView()
            break
        case .itunes:
            view.showItunesView()
            break
        }
    }
    
    func userTappedSearchButton(with searchString: String) {
        router.showEmbeddedServices(with: searchString)
    }
}
