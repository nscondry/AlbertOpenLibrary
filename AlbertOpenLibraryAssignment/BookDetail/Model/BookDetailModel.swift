//
//  BookDetailModel.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 7/1/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import Foundation
import UIKit

protocol BookDetailModelProtocol {
    func cacheImage(_ image: UIImage, _ url: URL)
    func getImage(_ url: URL) -> UIImage?
    func getFavoriteBooks() -> [BookData]
    func addFavoriteBook(_ data: BookData)
    func deleteFavoriteBook(_ data: BookData)
}

class BookDetailModel {
    
    private var imageCache = NSCache<AnyObject, AnyObject>()
    
    private var dataManager: CoreDataManager!
    
    init() {
        self.dataManager = CoreDataManager()
    }
    
    func cacheImage(_ image: UIImage, _ url: URL) {
        imageCache.setObject(image, forKey: url as AnyObject)
    }
    
    func getImage(_ url: URL) -> UIImage? {
        return imageCache.object(forKey: url as AnyObject) as? UIImage
    }
    
    func getFavoriteBooks() -> [BookData]  {
        return dataManager.getFavoriteBooks()
    }
    
    func addFavoriteBook(_ data: BookData) {
        dataManager.setFavoriteBook(data)
    }
    
    func deleteFavoriteBook(_ data: BookData) {
        dataManager.deleteFavoriteBook(data)
    }
}
