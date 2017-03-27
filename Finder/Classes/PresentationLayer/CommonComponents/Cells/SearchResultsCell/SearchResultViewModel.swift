//
//  SearchResultViewModel.swift
//  Finder
//
//  Created by Dmitrii on 18.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

struct SearchResultViewModel: CellViewModel {

    static let associatedCell: ConfigurableCell.Type = SearchResultCell.self
    
    let heading: String
    let body: String
    let image: String
    let delegate: SearchResultCellDelegate
}
