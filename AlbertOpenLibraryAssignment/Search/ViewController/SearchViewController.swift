//
//  SearchViewController.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/27/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    private var searchView: SearchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchView = SearchView(frame: UIScreen.main.bounds)
        self.view = searchView
        
        // navBar setup
        self.navigationItem.title = "Search"
        
        print("searchVC setup")
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
