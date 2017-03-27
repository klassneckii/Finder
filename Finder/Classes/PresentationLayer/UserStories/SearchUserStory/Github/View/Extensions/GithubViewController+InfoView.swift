//
//  GithubViewController+InfoView.swift
//  Finder
//
//  Created by Dmitrii on 26.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation
import UIKit

extension GithubViewController {
    func showInfoMessage(_ message:String) {
        let messageLabel = UILabel(frame: CGRect.init(x: 0, y: 0,
                                                      width: tableView.bounds.size.width,
                                                      height: tableView.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        
        dataDisplayManager.clear()
        
        UIView.animate(withDuration: 0.5, animations: {
            self.tableView.backgroundView = messageLabel;
            self.tableView.backgroundView?.alpha = 0
            self.tableView.backgroundView?.alpha = 1
        })
        
        tableView.separatorStyle = .none;
    }
    
    func hideInfoMessage() {
        tableView.backgroundView = nil;
        tableView.separatorStyle = .singleLine;
    }
}
