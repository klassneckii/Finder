//
//  SearchResultsCellViewModelFactory.swift
//  Finder
//
//  Created by Dmitrii on 21.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

/**
 View model factory for iTunes screen
 */
protocol ItunesCellViewModelFactory {
    
    /**
     Transform iTunes items to search result view models.
     
     - Parameter itunesItems: Array of iTunes search result entities.
     - Returns: Search result view models.
     */
    func viewModels(from itunesItems: [ITunesItem],
                    cellDelegate: SearchResultCellDelegate) -> [SearchResultViewModel]
}
