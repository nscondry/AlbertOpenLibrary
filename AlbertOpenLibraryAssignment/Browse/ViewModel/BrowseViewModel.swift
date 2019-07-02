//
//  BrowseViewModel.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 7/1/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import Foundation
import UIKit

class BrowseViewModel: SearchViewModel {
    
    var browseComplete: (([BrowsedBookData])->())?
    
    private var model: BrowseModel!
    
    override init() {
        self.model = BrowseModel()
    }
    
    func browseBooks(_ subject: String) {
        guard let url = URL(string: "https://openlibrary.org/subjects/\(subject).json?details=true") else { return }
        
        rest.makeRequest(toURL: url, withHttpMethod: .get) { response in
            if let data = response.data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let results = try? decoder.decode(BrowseResults.self, from: data) else { NSLog("[BrowseViewModel] Error: couldn't decode JSON"); return }
                
                // only display books that have covers
                if let bookData = results.works?.filter({ $0.coverId != nil }) {
                    self.model.setBrowseResultData(bookData)
                    
                    // begin caching images for initial results
                    Array(bookData.prefix(10)).forEach { book in
                        guard let id = book.coverId else { return }
                        self.getCoverImage(id: id, size: .M) {_ in }
                    }
                }
                
                // update cells
                DispatchQueue.main.async {
                    self.browseComplete?(self.model.getBrowseResultData())
                }
            }
        }
    }
}
