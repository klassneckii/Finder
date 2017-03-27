//
//  SearchResultCellDelegate.swift
//  Finder
//
//  Created by Dmitrii on 22.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation
import UIKit

protocol SearchResultCellDelegate: class {
    
    /**
     Passes image view that user tapped
     
     - Parameter coverImageView: tapped image view from UITableView cell
     */
    func coverImageViewTapped(coverImageView: UIImageView)
}
