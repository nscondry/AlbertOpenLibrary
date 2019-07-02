//
//  BrowseViewController.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 7/1/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class BrowseViewController: UIViewController {

    private var viewModel: BrowseViewModel!
    private var browseView: BrowseView!
    
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
            // image will be set asynchronously
            return nil
        }
        browseView.browseSubject = { subject in
            self.viewModel.browseBooks(subject.lowercased())
        }
        
        self.view = browseView
        
        // navBar setup
        self.navigationItem.title = "Browse"
        self.navigationController?.navigationBar.isHidden = true
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
