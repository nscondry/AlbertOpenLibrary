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
    
    init(fromBrowsedData data: BrowsedBookData) {
        
        if let coverID = data.coverId {
            self.coverI = coverID
        }
        
        if let hasFullText = data.hasFulltext {
            self.hasFulltext = hasFullText
        }
        
        if let editionCount = data.editionCount {
            self.editionCount = editionCount
        }
        
        if let firstPublishYear = data.firstPublishYear {
            self.firstPublishYear = firstPublishYear
        }
        
        if let title = data.title {
            self.title = title
        }
        
        if let authors = data.authors {
            self.authorName = authors.map({ $0.name ?? "Unknown Author" })
        }
        
        if let key = data.key {
            self.key = key
        }
    }
}

extension BookData: Equatable {
    public static func == (lhs: BookData, rhs: BookData) -> Bool {
        return
            lhs.key == rhs.key
    }
}

protocol SearchModelProtocol {
    func setSearchResultData(_ results: [BookData])
    func getSearchResultData() -> [BookData]?
    func cacheImage(_ image: UIImage, _ url: URL)
    func getImage(_ url: URL) -> UIImage?
    func setFavoriteBook(_ data: BookData)
    func deleteFavoriteBook(_ data: BookData)
    func getFavoriteKeys() -> [String]
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
