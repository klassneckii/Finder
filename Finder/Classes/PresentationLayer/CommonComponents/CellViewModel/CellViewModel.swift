//
//  CellViewModel.swift
//  Finder
//
//  Created by Dmitrii on 19.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

protocol CellViewModel {
    static var associatedCell: ConfigurableCell.Type { get }
}
