//
//  WishlistViewModel.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/28/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit
import CoreData

protocol WishlistViewModelProtocol {
    func retrieveFavoriteBooks(_ completion: @escaping(([BookData]?)->()))
    func getImage(forCoverID id: Int) -> UIImage?
}

class WishlistViewModel: WishlistViewModelProtocol {
    
    private var model: WishlistModel!
    
    init() {
        self.model = WishlistModel()
    }
    
    func retrieveFavoriteBooks(_ completion: @escaping(([BookData]?)->())) {
        model.retrieveFavoriteBooks() { data in
            completion(data)
        }
    }
    
    func getImage(forCoverID id: Int) -> UIImage? {
        return model.getImage(forCoverID: id)
    }
}
