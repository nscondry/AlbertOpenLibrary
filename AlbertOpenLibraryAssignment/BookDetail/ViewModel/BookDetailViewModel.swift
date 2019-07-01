//
//  BookDetailViewModel.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 7/1/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import Foundation
import UIKit

protocol BookDetailViewModelProtocol {
    func getCoverImage( id: Int, size: CoverImageSizes, completion: @escaping(_ coverImage: UIImage?)->())
    func retrieveCoverImage(fromURL url: URL, completion: @escaping(_ coverImage: UIImage)->())
}

class BookDetailViewModel: BookDetailViewModelProtocol {
    
    private var model: BookDetailModel!
    private var rest: RestManager!
    
    init() {
        self.model = BookDetailModel()
        self.rest = RestManager()
    }
    
    func getCoverImage( id: Int, size: CoverImageSizes, completion: @escaping(_ coverImage: UIImage?)->()) {
        guard let url = URL(string: "https://covers.openlibrary.org/b/id/" + String(id) + "-" + size.rawValue + ".jpg") else { return }
        
        if let coverImage = model.getImage(url) {
            completion(coverImage)
        } else {
            retrieveCoverImage(fromURL: url) { coverImage in
                self.model.cacheImage(coverImage, url)
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
}
