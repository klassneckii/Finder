//
//  SearchResultsViewController.swift
//  Finder
//
//  Created by Dmitry Parzehtsky on 18/03/2017.
//  Copyright © 2017 kl prod. All rights reserved.
//

import UIKit
import Dip_UI

class SearchResultsViewController: UIViewController, StoryboardInstantiatable, SearchResultsViewInput, UISearchBarDelegate {

    let defaultAnimationInterval = 0.5
    
    var output: SearchResultsViewOutput!

    @IBOutlet weak var serviceSegmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var itunesContainerView: UIView!
    @IBOutlet weak var githubContainerView: UIView!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    // MARK: SearchResultsViewInput
    func setupInitialStateWithApiMode(_ apiMode: ApiMode) {
        serviceSegmentedControl.selectedSegmentIndex = apiMode.rawValue
        switch apiMode {
        case .github:
            showGithubView()
        case .itunes:
            showItunesView()
        }
        setupSearchBar()
    }
    
    func showItunesView() {
        UIView.animate(withDuration: defaultAnimationInterval,
                       animations: {
                        self.itunesContainerView.alpha = 1
                        self.githubContainerView.alpha = 0
        })
    }
    
    func showGithubView() {
        UIView.animate(withDuration: defaultAnimationInterval,
                       animations: {
                        self.itunesContainerView.alpha = 0
                        self.githubContainerView.alpha = 1
        })
    }
    
    // MARK: Configuration
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
    }
    
    // MARK: UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        output.userTappedSearchButton(with: searchBar.text ?? "")
        searchBar.endEditing(true)
    }

    // MARK: UISegmentedControl events
    @IBAction func showService(_ sender: UISegmentedControl) {
        let apiMode = ApiMode(rawValue: sender.selectedSegmentIndex)
        output.userSwitchedApiModeTo(apiMode!)
    }
}
