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
    func getFavoriteBooks() -> [BookData]
    func getImage(forCoverID id: Int) -> UIImage?
    func deleteFavoriteBook(_ data: BookData)
}

class WishlistViewModel: WishlistViewModelProtocol {
    
    private var model: WishlistModel!
    
    init() {
        self.model = WishlistModel()
    }
    
    func getFavoriteBooks() -> [BookData] {
        return model.getFavoriteBooks()
    }
    
    func getImage(forCoverID id: Int) -> UIImage? {
        return model.getImage(forCoverID: id)
    }
    
    func deleteFavoriteBook(_ data: BookData) {
        model.deleteFavoriteBook(data)
    }
}
