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
        // testing; deleteMe
        viewModel.searchBooks("o")
        viewModel.searchComplete = { results in
            if let results = results { self.searchView.results = results }
        }

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
            // todo: handle data
            print("would push here...")
            self.pushViewController?(self, .detail, nil)
        }
        self.view = searchView
        
        // set saved favorites
        searchView.resultsTV.favoriteIDs = self.viewModel.getFavoriteIDs()
        
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
        searchView.resultsTV.favoriteIDs = self.viewModel.getFavoriteIDs()
        
        // reveal tabBar
        self.tabBarController?.tabBar.isHidden = false
        
        // enforce largeTitleMode
        self.navigationController?.navigationBar.prefersLargeTitles = true
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
