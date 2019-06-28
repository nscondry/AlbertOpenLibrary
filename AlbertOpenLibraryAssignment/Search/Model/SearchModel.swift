//
//  SearchModel.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/27/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import Foundation

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
        docsCount: \(docs)
        
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
    var publicScanB: Bool?
    
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
