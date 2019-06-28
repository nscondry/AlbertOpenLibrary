//
//  SearchModel.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/27/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import Foundation
import UIKit

var defString = String(stringLiteral: "")
var defInt = -1

struct SearchResults: Codable, CustomStringConvertible {
    var start: Int?
    var numFound: Int?
    var docs: [BookData]?
    
    var description: String {
        var desc = """
        start = \(start ?? defInt)
        number of results = \(numFound ?? defInt)
        docs: \(docs)
        
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
    var key: String?
    var ia: [String]?
    var authorKey: [String]?
    
    var description: String {
        let desc = """
        -------------------
        title = \(title ?? defString)
        author = \(authorName ?? [defString])
        -------------------
        """
        return desc
    }
}

struct BookDisplay {
    var data: BookData!
    var coverImage: UIImage?
    
    init(data: BookData, image: UIImage?) {
        self.data = data
        self.coverImage = image
    }
}

class SearchModel {
    
    private var searchResults: [BookData]?
    private var coverImages: [Int: UIImage]! = [:]
    
    func setSearchResultData(_ results: [BookData]) {
        searchResults = results
    }
    
    func getSearchResultData() -> [BookData]? {
        return searchResults ?? nil
    }
    
    func setCoverImage(_ coverID: Int, image: UIImage) {
        coverImages[coverID] = image
    }
    
    func getCoverImages() -> [Int: UIImage]? {
        return coverImages ?? nil
    }
    
    func getBookDisplays(count: Int = 10) -> [BookDisplay]? {
        guard let results = Array((searchResults?.prefix(count))!) as? [BookData] else { return nil }
        var displays: [BookDisplay] = []
        results.forEach { data in
            let image: UIImage? = (data.coverI == nil ? nil : coverImages![data.coverI!])
            print(image)
            print()
            let display = BookDisplay(data: data, image: image)
            displays.append(display)
        }
        print(displays.count)
        return displays
    }
    
}
