//
//  ConfigurableCell.swift
//  Finder
//
//  Created by Dmitrii on 19.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation
import UIKit

protocol ConfigurableCell {

    static var identifier: String { get }
    
    func configure(with viewModel: CellViewModel)
}

extension ConfigurableCell {
    static var identifier: String {
        return String(describing: self)
    }
}

protocol ConfigurableStaticHeightCell: ConfigurableCell {
    static var cellHeight: CGFloat { get }
}
