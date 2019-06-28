//
//  SearchViewController.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/27/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    private var rest: RestManager!
    private var searchView: SearchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rest = RestManager()

        searchView = SearchView(frame: UIScreen.main.bounds)
        self.view = searchView
        
        // navBar setup
        self.navigationItem.title = "Search"
        
        getBooks()
    }
    
    // testing REST calls
    func getBooks() {
        print("requesting...")
        guard let url = URL(string: "https://openlibrary.org/search.json?q=the+lord+of+the+rings") else { return }
        
        rest.makeRequest(toURL: url, withHttpMethod: .get) { results in
            if let data = results.data {
                print(data)
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                guard let userData = try? decoder.decode(UserData.self, from: data) else { return }
//                print(userData.description)
            }
        }
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
