//
//  SearchResultsCellViewModelFactory.swift
//  Finder
//
//  Created by Dmitrii on 21.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

/**
 View model factory for search results screen
 */
protocol GithubCellViewModelFactory {
    
    /**
     Transform Github items to search result view models.
     
     - Parameter githubItems: Array of iTunes search result entities.
     - Returns: Search result view models.
     */
    func viewModels(from githubItems: [GithubItem], cellDelegate: SearchResultCellDelegate) -> [SearchResultViewModel]
}
