//
//  TableViewDataDisplayManager.swift
//  Finder
//
//  Created by Dmitrii on 19.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation
import UIKit

protocol TableViewDataDisplayManager: UITableViewDataSource, UITableViewDelegate  {
    func dataSourceForTableView() -> UITableViewDataSource
    func delegateForTableView() -> UITableViewDelegate
}

extension TableViewDataDisplayManager {
    func dataSourceForTableView() -> UITableViewDataSource {
        return self
    }
    
    func delegateForTableView() -> UITableViewDelegate {
        return self
    }
}
