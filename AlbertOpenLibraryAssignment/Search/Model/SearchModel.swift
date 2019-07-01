//
//  SearchModel.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/27/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import Foundation
import UIKit
import CoreData

var defString = String(stringLiteral: "ERROR")
var defInt = -1

struct SearchResults: Codable {
    var start: Int?
    var numFound: Int?
    var docs: [BookData]?
}

struct BookData: Codable {
    
    var coverI: Int?
    var hasFulltext: Bool?
    var editionCount: Int?
    var title: String?
    var authorName: [String]?
    var firstPublishYear: Int?
    var key: String?
    
    init(fromManagedObject object: NSManagedObject) {
        
        if let coverID = object.value(forKey: "coverID") as? Int {
            self.coverI = coverID
        }
        
        if let hasFullText = object.value(forKey: "hasFullText") as? Bool {
            self.hasFulltext = hasFullText
        }
        
        if let editionCount = object.value(forKey: "editionCount") as? Int {
            self.editionCount = editionCount
        }
        
        if let firstPublishYear = object.value(forKey: "firstPublishYear") as? Int {
            self.firstPublishYear = firstPublishYear
        }
        
        if let title = object.value(forKey: "title") as? String {
            self.title = title
        }
        
        if let authorNames = object.value(forKey: "authorNames") as? [String] {
            self.authorName = authorNames
        }
        
        if let key = object.value(forKey: "key") as? String {
            self.key = key
        }
    }
}

extension BookData: Equatable {
    public static func == (lhs: BookData, rhs: BookData) -> Bool {
        return
            lhs.coverI == rhs.coverI &&
            lhs.hasFulltext == rhs.hasFulltext &&
            lhs.editionCount == rhs.editionCount &&
            lhs.title == rhs.title &&
            lhs.authorName == rhs.authorName &&
            lhs.firstPublishYear == rhs.firstPublishYear &&
            lhs.key == rhs.key
    }
}

class SearchModel {
    
    private var searchResults: [BookData]?
    private var imageCache = NSCache<AnyObject, AnyObject>()
    
    private var dataManager: CoreDataManager!
    
    init() {
        self.dataManager = CoreDataManager()
        dataManager.getImageFromURL = { url in
            return self.getImage(url)
        }
    }
    
    func setSearchResultData(_ results: [BookData]) {
        searchResults = results
    }
    
    func getSearchResultData() -> [BookData]? {
        return searchResults
    }
    
    func cacheImage(_ image: UIImage, _ url: URL) {
        imageCache.setObject(image, forKey: url as AnyObject)
    }
    
    func getImage(_ url: URL) -> UIImage? {
        return imageCache.object(forKey: url as AnyObject) as? UIImage
    }
    
    //
    // MARK: - Core Data Functions
    //
    
    func setFavoriteBook(_ data: BookData) {
        dataManager.setFavoriteBook(data)
    }
    
    func deleteFavoriteBook(_ data: BookData) {
        dataManager.deleteFavoriteBook(data)
    }
    
    func getFavoriteKeys() -> [String] {
        return dataManager.getFavoriteKeys()
    }
}
