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

        searchView = SearchView(frame: UIScreen.main.bounds)
        self.view = searchView
        
        // navBar setup
        self.navigationItem.title = "Search"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // testing REST calls
//    func getBooks() {
//        print("requesting...")
//        guard let url = URL(string: "https://openlibrary.org/search.json?subject=science") else { return }
//
//        rest.makeRequest(toURL: url, withHttpMethod: .get) { results in
//            print(results)
//            if let data = results.data {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                guard let results = try? decoder.decode(SearchResults.self, from: data) else { print("didnt work..."); return }
//                    print(results.description)
//            }
//        }
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
