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
            return self.viewModel.getImage(forCoverID: id)
        }
        resultsTV.pushDetailView = { data in
            // todo handle data
            self.pushViewController?(self, .detail, data)
        }
        resultsTV.toggleFavorite = { data, isFavorite in
            guard !isFavorite else { return }
            self.viewModel.deleteFavoriteBook(data)
            self.refreshFavoriteBooks()
        }
        
        self.view = resultsTV

        viewModel = WishlistViewModel()
        
        // navBar setup
        self.navigationItem.title = "Wishlist"
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // refresh retrieved books, update if changed
        refreshFavoriteBooks()
        
        // reveal tabBar
        self.tabBarController?.tabBar.isHidden = false
        
        // enforce largeTitleMode
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func refreshFavoriteBooks() {
        // refresh retrieved books, update if changed
        let favoriteBooks = viewModel.getFavoriteBooks()
        guard favoriteBooks != self.resultsTV.results else { return }
        
        favoriteBooks.forEach { book in
            guard let key = book.key else { return }
            self.resultsTV.favoriteKeys.append(key)
        }
        self.resultsTV.results = favoriteBooks
    }
}
