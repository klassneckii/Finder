//
//  SearchResultDataDisplayManager.swift
//  Finder
//
//  Created by Dmitrii on 19.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation
import UIKit

protocol ItunesDataDisplayManager: TableViewDataDisplayManager {
    
    /**
     Update iTunes entities in cells
     
     - parameter itunesItems: Search results from iTunes
     */
    func update(_ itunesItems: [ITunesItem], cellDelegate: SearchResultCellDelegate)
    
    /**
     Clears table view
     */
    func clear()
}
