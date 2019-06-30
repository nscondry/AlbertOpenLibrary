//
//  BookDetailViewController.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/30/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController, RouterDelegateProtocol {

    var popViewController: ((UIViewController, Any?) -> ())?
    
    var data: BookData! {
        didSet {
            print("set data...")
        }
    }
    
    private var detailView: BookDetailView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailView = BookDetailView()
        self.view = detailView
        
        // navBar setup
        self.navigationItem.title = "BookDetail"
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // hide tabBar
        self.tabBarController?.tabBar.isHidden = true
        
        // enforce smallTitleMode
        self.navigationController?.navigationBar.prefersLargeTitles = false
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