//
//  WishlistViewController.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/27/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class WishlistViewController: UIViewController {

    
    private var viewModel: WishlistViewModel!
    
    lazy var resultsTV: ResultsTableView = {
        let resultsTV = ResultsTableView(frame: self.view.bounds, style: .plain)
        resultsTV.backgroundColor = .white
        resultsTV.translatesAutoresizingMaskIntoConstraints = false
        return resultsTV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsTV.getCellImage = { id in
            print("attempting to get image...")
            if let coverImage = self.viewModel.getImage(forID: id) {
                self.resultsTV.setCellImage(id, coverImage)
            }
        }
        
        self.view = resultsTV

        viewModel = WishlistViewModel()
        viewModel.retrieveFavoriteBooks() { favoriteBooks in
            guard favoriteBooks != nil else { return }
            favoriteBooks!.forEach { book in
                self.resultsTV.favoriteIDs.append(book.coverI!)
            }
            self.resultsTV.results = favoriteBooks
        }
        
        // navBar setup
        self.navigationItem.title = "Wishlist"
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
