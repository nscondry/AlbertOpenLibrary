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
    
    func setFavoriteBooks(_ bookData: [BookData]) {
        favoriteBooks = bookData
    }
    
    func getFavoriteBooks() -> [BookData]? {
        return favoriteBooks ?? nil
    }
}
