//
//  GithubViewController.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 26/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

import UIKit
import Dip_UI

class GithubViewController: UIViewController, StoryboardInstantiatable, GithubViewInput, SearchResultCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var animator: CoverImageViewAnimator!
    
    var output: GithubViewOutput!
    var dataDisplayManager: GithubDataDisplayManager!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        output.viewIsReady()
    }
    
    // MARK: GithubViewInput
    func setupInitialState() {

    }
    
    func update(_ githubItems: [GithubItem]) {
        hideActivityIndicator()
        if githubItems.isEmpty {
            showInfoMessage("Nothing was found on Github 😔")
        } else {
            dataDisplayManager.update(githubItems, cellDelegate: self)
            tableView.reloadData()
        }
    }
    
    func searchStarted() {
        clearTableView()
        showActivityIndicator()
    }
    
    func searchFailed(description: String) {
        activityIndicator.stopAnimating()
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
        dataDisplayManager.clear()
        tableView.reloadData()
    }
    
    // MARK: SearchResultCellDelegate
    func coverImageViewTapped(coverImageView: UIImageView) {
        animator.animateToFullScreen(imageView: coverImageView)
    }
}


