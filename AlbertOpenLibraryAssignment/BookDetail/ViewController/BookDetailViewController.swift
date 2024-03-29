//
//  BookDetailViewController.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/30/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    var data: BookData!
    
    private var detailView: BookDetailView!
    private var viewModel: BookDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = BookDetailViewModel()
        
        detailView = BookDetailView()
        detailView.getCoverImage = { coverID in
            self.viewModel.getCoverImage(id: coverID, size: .M) { coverImage in
                DispatchQueue.main.async {
                    self.detailView.cover = coverImage
                }
            }
        }
        detailView.toggleFavorite = { data, isFavorite in
            if isFavorite {
                self.viewModel.addFavoriteBook(data)
            } else {
                self.viewModel.deleteFavoriteBook(data)
            }
        }
        detailView.dismissSelf = self.dismissSelf
        detailView.bookData = self.data
        detailView.isFavorite = viewModel.getFavoriteBooks().contains(self.data)
        self.view = detailView
        
        // navBar setup
        self.navigationItem.title = "BookDetail"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        // transitionStyle
        modalTransitionStyle = .crossDissolve
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // hide tabBar
        self.tabBarController?.tabBar.isHidden = true
        
        // enforce smallTitleMode
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.isHidden = false
        
        // animate views in
        DispatchQueue.main.async {
            self.detailView.animateIn()
        }
    }
    
    private func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
    }
}
