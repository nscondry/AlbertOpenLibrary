//
//  SearchViewModel.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/27/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

enum SearchTypes: String {
    case all
    case title
    case author
    case subject
}

class SearchViewModel {
    
    var searchResultsUpdated: (([BookData])->())?
    
    private var model: SearchModel!
    private var rest: RestManager!
    private var searchType: SearchTypes! = .all
    
    init() {
        self.model = SearchModel()
    }
    
    func setSearchType(_ type: SearchTypes) {
        self.searchType = type
    }
    
    func searchBooks(_ query: String) {
        var typeString: String! = (self.searchType! == .all ? "q=" : "\(searchType.rawValue)=")
        guard let url = URL(string: "https://openlibrary.org/search.json?" + typeString + query) else { return }
        
        rest.makeRequest(toURL: url, withHttpMethod: .get) { results in
            if let data = results.data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let results = try? decoder.decode(SearchResults.self, from: data) else { NSLog("[SearchViewModel] Error: couldn't decode JSON"); return }
                self.model.setSearchResultData(results.docs!)
                self.searchResultsUpdated?(results.docs!)
            }
        }
    }

}
