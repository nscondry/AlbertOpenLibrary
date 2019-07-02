//
//  SearchViewController.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/27/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, RouterDelegateProtocol {

    //
    // MARK: - Router Delegate Protocol Functions
    //
    
    var pushViewController: ((UIViewController, LibraryViewControllers, Any?) -> ())?
    
    //
    // MARK: - View Controller Functions
    //
    
    private var viewModel: SearchViewModel!
    private var searchView: SearchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = SearchViewModel()
        
        //
        // MARK: - DELETE ME WHEN DONE TESTING
        //
        viewModel.searchBooks("o")
        viewModel.searchComplete = { results in
            if let results = results { self.searchView.results = results }
        }
        //
        // ^^^^^^^DONT FORGET
        //

        searchView = SearchView(frame: UIScreen.main.bounds)
        searchView.getCellImage = { coverID in
            self.viewModel.getCoverImage(id: coverID, size: .M) { coverImage in
                DispatchQueue.main.async {
                    self.searchView.resultsTV.setCellImage(coverID, coverImage!)
                }
            }
            // image will be set asynchronously
            return nil
        }
        searchView.toggleFavorite = { data, isFavorite in
            if isFavorite {
                self.viewModel.setFavoriteBook(data)
            } else {
                self.viewModel.deleteFavoriteBook(data)
            }
        }
        searchView.pushDetailView = { data in
            self.pushViewController?(self, .detail, data)
        }
        self.view = searchView
        
        // set saved favorites
        searchView.resultsTV.favoriteKeys = self.viewModel.getFavoriteKeys()
        
        // navBar setup
        self.navigationItem.title = "Search"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // search setup
        self.definesPresentationContext = true
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        search.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = search
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // reset saved favorites in case they changed
        if searchView.resultsTV.favoriteKeys != self.viewModel.getFavoriteKeys() {
            searchView.resultsTV.favoriteKeys = self.viewModel.getFavoriteKeys()
            searchView.resultsTV.reloadData()
        }
        
        // reveal tabBar
        self.tabBarController?.tabBar.isHidden = false
        
        // enforce largeTitleMode
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // disable when view will appear so searchbar is revealed by default
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // enable once view appears so search bar will hide normally
        navigationItem.hidesSearchBarWhenScrolling = true
    }
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        self.viewModel.searchBooks(text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        self.viewModel.searchBooks(text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.searchBooks("o")
    }
}
