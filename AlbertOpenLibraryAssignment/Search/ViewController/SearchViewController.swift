//
//  SearchViewController.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/27/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    private var viewModel: SearchViewModel!
    private var searchView: SearchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = SearchViewModel()
        viewModel.searchBooks("o")
        viewModel.searchComplete = { results in
            guard results != nil else { return }
            self.searchView.results = results
        }

        searchView = SearchView(frame: UIScreen.main.bounds)
        searchView.getCellImage = { coverID in
            self.viewModel.getCoverImage(coverID, .M) { coverImage in
                DispatchQueue.main.async {
                    self.searchView.resultsTV.setCellImage(coverID, coverImage!)
                }
            }
        }
        searchView.toggleFavorite = { data, isFavorite in
            print("called")
            if isFavorite {
                self.viewModel.setFavoriteBook(data)
            } else {
                self.viewModel.deleteFavoriteBook(data)
            }
        }
        self.view = searchView
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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
