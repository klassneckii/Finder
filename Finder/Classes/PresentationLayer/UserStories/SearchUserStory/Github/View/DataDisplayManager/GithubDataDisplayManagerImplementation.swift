//
//  SearchResultsDataDisplayManagerImplementation.swift
//  Finder
//
//  Created by Dmitrii on 19.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation
import UIKit

class GithubDataDisplayManagerImplementation: NSObject, GithubDataDisplayManager {

    var viewModels: [SearchResultViewModel] = []
    var factory: GithubCellViewModelFactory!
    var imageLoader: ImageCacheLoader!
    
    // MARK: - SearchResultsDataDisplayManager protocol
    
    func update(_ githubItems: [GithubItem], cellDelegate: SearchResultCellDelegate) {
        viewModels = factory.viewModels(from: githubItems,
                                        cellDelegate: cellDelegate)
    }
    
    func clear() {
        viewModels.removeAll()
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let viewModel = viewModels[indexPath.row]
        let viewModelType = type(of: viewModel)
        
        let cellIdentifier = viewModelType.associatedCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! SearchResultCell
 
        cell.configure(with: viewModel)
        
        imageLoader.obtainImageWithPath(imagePath: viewModel.image) { (image) in
            // Before assigning the image, check whether the current cell is visible
            if let updateCell = tableView.cellForRow(at: indexPath) as? SearchResultCell {
                updateCell.coverImageView.image = image
            }
        }
        
        let rightLayoutNeeded = (indexPath.row % 2) == 0
        if rightLayoutNeeded {
            cell.setRightLayout()
        } else {
            cell.setLeftLayout()
        }
        
        return cell as UITableViewCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SearchResultCell.cellHeight
    }
}
