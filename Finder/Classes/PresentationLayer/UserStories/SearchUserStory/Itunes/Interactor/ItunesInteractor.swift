//
//  ItunesInteractor.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 26/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

class ItunesInteractor: ItunesInteractorInput {
    weak var output: ItunesInteractorOutput!
    
    var iTunesService: ITunesService!
    
    func obtainSearchResults(by term: String) {

        let itunesCompletionClosure: ITunesSearchResultResponseThrowable = { [weak self] itunesSearchResultResponse in
            guard let strongSelf = self else {
                return
            }
            do {
                let response = try itunesSearchResultResponse()
                strongSelf.output.didReceiveITunesItems(response.items)
            } catch let error {
                strongSelf.output.didFail(withError: error)
            }
        }
        
        let itunesSearchConfiguration = ITunesSearchServiceConfiguration(term: term)
        iTunesService.search(with: itunesSearchConfiguration, completion: itunesCompletionClosure)
    }
}
