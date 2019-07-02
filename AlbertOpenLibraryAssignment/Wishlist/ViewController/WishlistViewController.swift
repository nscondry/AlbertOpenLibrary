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
    
    var presentViewController: ((UIViewController, LibraryViewControllers, Any?) -> ())?
    
    //
    // MARK: - View Controller Functions
    //
    
    private var viewModel: WishlistViewModel!
    
    lazy var resultsTV: BookTableView = {
        let resultsTV = BookTableView(frame: self.view.bounds, style: .plain)
        resultsTV.backgroundColor = .white
        resultsTV.translatesAutoresizingMaskIntoConstraints = false
        return resultsTV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsTV.getCellImage = { id in
            return self.viewModel.getImage(forCoverID: id)
        }
        resultsTV.presentDetailView = { data in
            // todo handle data
            self.presentViewController?(self, .detail, data)
        }
        resultsTV.toggleFavorite = { data, isFavorite in
            guard !isFavorite else { return }
            self.showDeleteAlert(forBookData: data)
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
    
    private func showDeleteAlert(forBookData data: BookData) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let delete = UIAlertAction(title: "Remove from wishlist", style: .destructive) { (action) in
            self.viewModel.deleteFavoriteBook(data)
            self.refreshFavoriteBooks()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // reset heartIcon & dismiss alert
            self.resultsTV.setFavorite(forBooData: data)
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(delete)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
        // this produces a constraint conflict
        // the conflict is a known bug http://openradar.appspot.com/49289931
        // code below should silence the constraint conflict alert
        alert.view.subviews.flatMap({$0.constraints}).filter{ (one: NSLayoutConstraint)-> (Bool)  in
            return (one.constant < 0) && (one.secondItem == nil) &&  (one.firstAttribute == .width)
            }.first?.isActive = false
    }
}
