//
//  BrowseViewController.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 7/1/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class BrowseViewController: UIViewController, RouterDelegateProtocol {
    
    //
    // MARK: - Router Delegate Protocol Functions
    //
    
    var presentViewController: ((UIViewController, LibraryViewControllers, Any?) -> ())?

    //
    // MARK: - View Controller Functions
    //
    
    private var viewModel: BrowseViewModel!
    private var browseView: BrowseView!
    private var searchButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = BrowseViewModel()
        viewModel.browseBooks("art")
        viewModel.browseComplete = { data in
            self.browseView.bookCV.books = data
        }

        browseView = BrowseView(frame: view.bounds)
        browseView.getCellImage = { coverID in
            self.viewModel.getCoverImage(id: coverID, size: .M) { coverImage in
                DispatchQueue.main.async {
                    self.browseView.bookCV.setCellImage(coverID, coverImage!)
                }
            }
        }
        browseView.browseSubject = { subject in
            self.viewModel.browseBooks(subject.lowercased())
            self.navigationItem.title = "Browse: \(subject)"
        }
        browseView.presentDetailView = { data in
            self.presentViewController?(self, .detail, data)
        }
        
        self.view = browseView
        
        // navBar setup
        self.navigationItem.title = "Browse: Art"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = Colors.customRed
        self.navigationController?.navigationBar.shadowImage = UIImage()
        extendedLayoutIncludesOpaqueBars = true
        
        // searchButton
        searchButton = UIBarButtonItem(image: UIImage(named: "searchIcon"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(presentSearchVC))
        searchButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = searchButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // format nav & reveal tabBar
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tabBarController?.tabBar.isHidden = false
        
        // animate collectionViews
        browseView.subjectCV.animateIn()
        browseView.bookCV.animateCells(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // prepare collectionViews for animation
        browseView.subjectCV.alpha = 0
    }

    @objc private func presentSearchVC() {
        self.presentViewController?(self, .search, nil)
    }
}
