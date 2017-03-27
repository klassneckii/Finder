//
//  ItunesViewController.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 26/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

import UIKit
import Dip_UI

class ItunesViewController: UIViewController, StoryboardInstantiatable, ItunesViewInput, SearchResultCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var animator: CoverImageViewAnimator!
    
    var output: ItunesViewOutput!
    var dataDisplayManager: ItunesDataDisplayManager!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        output.viewIsReady()
    }
    
    // MARK: ItunesViewInput
    func setupInitialState() {
    }
    
    func update(_ itunesItems: [ITunesItem]) {
        hideActivityIndicator()
        if itunesItems.isEmpty {
            showInfoMessage("Nothing was found on iTunes 😔")
        } else {
            dataDisplayManager.update(itunesItems, cellDelegate: self)
            tableView.reloadData()
        }
    }

    func searchStarted() {
        clearTableView()
        showActivityIndicator()
    }
    
    func searchFailed(description: String) {
        hideActivityIndicator()
        dataDisplayManager.clear()
        showInfoMessage(description)
    }
    
    // MARK: Configuration
    private func setupTableView() {
        let searchResult = UINib(nibName: SearchResultCell.identifier, bundle: Bundle.main)
        tableView.register(searchResult, forCellReuseIdentifier: SearchResultCell.identifier)
        tableView.delegate = dataDisplayManager.delegateForTableView()
        tableView.dataSource = dataDisplayManager.dataSourceForTableView()
        tableView.keyboardDismissMode = .onDrag;
        tableView.tableFooterView = UIView.init()
    }
    
    private func clearTableView() {
        hideInfoMessage()
        dataDisplayManager.clear()
        tableView.reloadData()
    }
    
    //MARK: SearchResultCellDelegate
    func coverImageViewTapped(coverImageView: UIImageView) {
        animator.animateToFullScreen(imageView: coverImageView)
    }
}
