//
//  GithubViewController+ActivityIndicator.swift
//  Finder
//
//  Created by Dmitrii on 26.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

extension GithubViewController {
    
    func showActivityIndicator() {
        tableView.backgroundView = activityIndicator
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        tableView.backgroundView = nil
        activityIndicator.stopAnimating()
    }
}
