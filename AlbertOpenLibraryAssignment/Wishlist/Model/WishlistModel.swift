//
//  WishlistModel.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/28/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import Foundation
import UIKit

protocol WishlistModelProtocol {
    func getFavoriteBooks() -> [BookData]
    func getImage(forCoverID id: Int) -> UIImage?
}

class WishlistModel {
    
    private var dataManager: CoreDataManager!
    
    init() {
        self.dataManager = CoreDataManager()
    }
    
    func getFavoriteBooks() -> [BookData]  {
        return dataManager.getFavoriteBooks()
    }
    
    func getImage(forCoverID id: Int) -> UIImage? {
        return dataManager.getImage(forCoverID: id)
    }
}
