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
    func getCoverImage(id: Int, size: CoverImageSizes, completion: @escaping(_ coverImage: UIImage?)->())
    func retrieveCoverImage(fromURL url: URL, completion: @escaping(_ coverImage: UIImage)->())
    func deleteFavoriteBook(_ data: BookData)
}

class WishlistViewModel: WishlistViewModelProtocol {
    
    var rest: RestManager!
    private var model: WishlistModel!
    
    init() {
        self.model = WishlistModel()
        self.rest = RestManager()
    }
    
    func getFavoriteBooks() -> [BookData] {
        return model.getFavoriteBooks()
    }
    
    func getCoverImage(id: Int, size: CoverImageSizes = .S, completion: @escaping(_ coverImage: UIImage?)->()) {
        guard let url = URL(string: "https://covers.openlibrary.org/b/id/" + String(id) + "-" + size.rawValue + ".jpg") else { return }
        
        if let coverImage = model.getImage(forCoverID: id) {
            completion(coverImage)
        } else {
            retrieveCoverImage(fromURL: url) { coverImage in
                completion(coverImage)
            }
        }
    }
    
    func retrieveCoverImage(fromURL url: URL, completion: @escaping(_ coverImage: UIImage)->()) {
        rest.makeRequest(toURL: url, withHttpMethod: .get) { response in
            if let data = response.data, response.error == nil {
                guard let coverImage = UIImage(data: data) else { return }
                completion(coverImage)
            }
        }
    }
    
    func deleteFavoriteBook(_ data: BookData) {
        model.deleteFavoriteBook(data)
    }
}
