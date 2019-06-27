//
//  WishlistViewController.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/27/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class WishlistViewController: UIViewController {

    private var wishlistView: WishlistView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wishlistView = WishlistView()
        self.view = wishlistView
        
        // navBar setup
        self.navigationItem.title = "wishlist"
        
        print("wishVC setup")
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
