 //
//  TourSearchCityCellViewModelFactoryImplementation.swift
//  Finder
//
//  Created by Dmitrii on 21.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

class GithubCellViewModelFactoryImplementation: GithubCellViewModelFactory {
    
    func viewModels(from githubItems: [GithubItem],
                    cellDelegate: SearchResultCellDelegate) -> [SearchResultViewModel] {
        return githubItems.map{ item in
            return SearchResultViewModel(heading: item.login,
                                         body: item.accountURL,
                                         image: item.avatarPath,
                                         delegate: cellDelegate)
        }
    }
}
