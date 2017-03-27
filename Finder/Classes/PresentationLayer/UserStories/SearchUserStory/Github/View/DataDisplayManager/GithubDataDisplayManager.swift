//
//  SearchResultDataDisplayManager.swift
//  Finder
//
//  Created by Dmitrii on 19.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation
import UIKit

protocol GithubDataDisplayManager: TableViewDataDisplayManager {
    
    /**
     Update Github entities in cells
     
     - parameter githubItems: Search results from Github
     */
    func update(_ githubItems: [GithubItem], cellDelegate: SearchResultCellDelegate)
    
    /**
     Clears table view
     */
    func clear()
}
