//
//  WishlistModel.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/28/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import Foundation
import UIKit

class WishlistModel {
    
    private var favoriteBooks: [BookData]?
    
    private var dataManager: CoreDataManager!
    
    init() {
        self.dataManager = CoreDataManager()
        dataManager.setFavoriteBooks = { books in
            self.setFavoriteBooks(books)
        }
    }
    
    func setFavoriteBooks(_ bookData: [BookData]) {
        favoriteBooks = bookData
    }
    
    func retrieveFavoriteBooks(completion: @escaping(([BookData]?)->()))  {
        dataManager.retrieveFavoriteBooks {
            completion(self.favoriteBooks)
        }
    }
    
    func getImage(forCoverID id: Int) -> UIImage? {
        return dataManager.getImage(forCoverID: id)
    }
}
