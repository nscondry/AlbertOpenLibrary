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
        viewModel.searchBooks("The Lord of the Rings")
        viewModel.searchComplete = { results in
            guard results != nil else { return }
            self.searchView.results = results
        }

        searchView = SearchView(frame: UIScreen.main.bounds)
        searchView.getCellImage = { coverID in
            return self.viewModel.getCoverImage(coverID, size: .M)
        }
        self.view = searchView
        
        // navBar setup
        self.navigationItem.title = "Search"
        self.navigationController?.navigationBar.prefersLargeTitles = true
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
