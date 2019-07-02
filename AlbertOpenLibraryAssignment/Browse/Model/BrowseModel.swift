//
//  BrowseModel.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 7/1/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import Foundation
import UIKit

struct BrowseResults: Codable {
    var works: [BrowsedBookData]?
}

struct BrowsedBookData: Codable {
    // different struct than browse data due to different API variable names
    // BookData can be initialized with BrowsedBookData
    
    var coverId: Int?
    var hasFulltext: Bool?
    var editionCount: Int?
    var title: String?
    var authors: [Author]?
    var firstPublishYear: Int?
    var key: String?
}

struct Author: Codable {
    var name: String?
}

protocol BrowseModelProtocol {
    func setBrowseResultData(_ results: [BrowsedBookData])
    func getBrowseResultData() -> [BrowsedBookData]
}

class BrowseModel: SearchModel, BrowseModelProtocol {
    
    private var browseResults: [BrowsedBookData]?
    
    func setBrowseResultData(_ results: [BrowsedBookData]) {
        browseResults = results
    }
    
    func getBrowseResultData() -> [BrowsedBookData] {
        return browseResults ?? []
    }
    
}
