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
    var title: String?
    var coverId: Int?
    var key: String?
}

class BrowseModel: SearchModel {
    
    private var browseResults: [BrowsedBookData]?
    
    func setBrowseResultData(_ results: [BrowsedBookData]) {
        browseResults = results
    }
    
    func getBrowseResultData() -> [BrowsedBookData] {
        return browseResults ?? []
    }
    
}
