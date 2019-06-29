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

struct SearchResults: Codable, CustomStringConvertible {
    var start: Int?
    var numFound: Int?
    var docs: [BookData]?
    
    var description: String {
        var desc = """
        start = \(start ?? defInt)
        number of results = \(numFound ?? defInt)
        docs: \(docs!)
        
        """
        if let bookData = docs {
            bookData.forEach { book in
                desc += book.description
            }
        }
        return desc
    }
}

struct BookData: Codable, CustomStringConvertible {
    
    var coverI: Int?
    var hasFulltext: Bool?
    var editionCount: Int?
    var title: String?
    var authorName: [String]?
    var firstPublishYear: Int?
    
    var description: String {
        let desc = """
        -------------------
        title = \(title ?? defString)
        author = \(authorName ?? [defString])
        -------------------
        """
        return desc
    }
    
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
            lhs.firstPublishYear == rhs.firstPublishYear
    }
}

class SearchModel {
    
    private var searchResults: [BookData]?
    private var imageCache = NSCache<AnyObject, AnyObject>()
    
    func setSearchResultData(_ results: [BookData]) {
        searchResults = results
    }
    
    func getSearchResultData() -> [BookData]? {
        return searchResults ?? nil
    }
    
    func cacheImage(_ image: UIImage, _ url: URL) {
        imageCache.setObject(image, forKey: url as AnyObject)
    }
    
    func getImage(_ url: URL) -> UIImage? {
        return imageCache.object(forKey: url as AnyObject) as? UIImage
    }
}
