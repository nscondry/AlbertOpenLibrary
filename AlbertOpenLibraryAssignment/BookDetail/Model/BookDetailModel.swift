//
//  BookDetailModel.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 7/1/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import Foundation
import UIKit

class BookDetailModel {
    
    private var imageCache = NSCache<AnyObject, AnyObject>()
    
    func cacheImage(_ image: UIImage, _ url: URL) {
        imageCache.setObject(image, forKey: url as AnyObject)
    }
    
    func getImage(_ url: URL) -> UIImage? {
        return imageCache.object(forKey: url as AnyObject) as? UIImage
    }
    
}
