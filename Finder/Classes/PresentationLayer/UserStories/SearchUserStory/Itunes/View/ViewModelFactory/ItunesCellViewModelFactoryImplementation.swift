 //
//  TourSearchCityCellViewModelFactoryImplementation.swift
//  Finder
//
//  Created by Dmitrii on 21.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

class ItunesCellViewModelFactoryImplementation: ItunesCellViewModelFactory {
    
    func viewModels(from itunesItems: [ITunesItem],
                    cellDelegate: SearchResultCellDelegate) -> [SearchResultViewModel] {
        return itunesItems.map { item in
            return SearchResultViewModel(heading: item.title,
                                         body: item.author,
                                         image: item.cover,
                                         delegate: cellDelegate)
        }
    }
}
