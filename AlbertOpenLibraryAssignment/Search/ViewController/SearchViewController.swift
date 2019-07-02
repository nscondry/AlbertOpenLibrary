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
    
    var presentViewController: ((UIViewController, LibraryViewControllers, Any?) -> ())?
    
    //
    // MARK: - View Controller Functions
    //
    
    private var viewModel: SearchViewModel!
    private var searchView: SearchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = SearchViewModel()
        viewModel.searchComplete = { results in
            if let results = results { self.searchView.results = results }
        }
        
        searchView = SearchView(frame: UIScreen.main.bounds)
        searchView.getCellImage = { coverID in
            self.viewModel.getCoverImage(id: coverID, size: .M) { coverImage in
                DispatchQueue.main.async {
                    if let coverImage = coverImage {
                        self.searchView.resultsTV.setCellImage(coverID, coverImage)
                    }
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
        searchView.presentDetailView = { data in
            self.presentViewController?(self, .detail, data)
        }
        searchView.searchBooks = { query in
            self.viewModel.searchBooks(query)
        }
        searchView.setScope = { searchType in
            self.viewModel.setSearchType(searchType)
        }
        searchView.dismissSelf = {
            self.dismiss(animated: true, completion: nil)
        }
        self.view = searchView
        
        // set saved favorites
        searchView.resultsTV.favoriteKeys = self.viewModel.getFavoriteKeys()
        
        // set transition style
        self.modalTransitionStyle = .crossDissolve
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // resign first responder if active
        if searchView.searchBar.isFirstResponder {
            searchView.searchBar.resignFirstResponder()
        }
    }
}
