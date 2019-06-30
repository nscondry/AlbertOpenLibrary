//
//  WishlistViewController.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/27/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class WishlistViewController: UIViewController, RouterDelegateProtocol {

    //
    // MARK: - Router Delegate Protocol Functions
    //
    
    var pushViewController: ((UIViewController, LibraryViewControllers, Any?) -> ())?
    
    //
    // MARK: - View Controller Functions
    //
    
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
            return self.viewModel.getImage(forID: id)
        }
        resultsTV.pushDetailView = { data in
            // todo handle data
            self.pushViewController?(self, .detail, nil)
        }
        
        self.view = resultsTV

        viewModel = WishlistViewModel()
        
        
        // navBar setup
        self.navigationItem.title = "Wishlist"
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // refresh retrieved books, update if changed
        viewModel.retrieveFavoriteBooks() { favoriteBooks in
            guard let favoriteBooks = favoriteBooks, favoriteBooks != self.resultsTV.results else { return }
            favoriteBooks.forEach { book in
                self.resultsTV.favoriteIDs.append(book.coverI!)
            }
            self.resultsTV.results = favoriteBooks
        }
        
        // enforce largeTitleMode
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
