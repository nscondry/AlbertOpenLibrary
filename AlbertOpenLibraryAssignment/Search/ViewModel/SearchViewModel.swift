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

enum CoverImageSizes: String {
    case S
    case M
    case L
}

class SearchViewModel {
    
    var searchComplete: (([BookDisplay]?)->())?
    
    private var model: SearchModel!
    private var rest: RestManager!
    private var searchType: SearchTypes! = .all
    
    init() {
        self.model = SearchModel()
        self.rest = RestManager()
    }
    
    func setSearchType(_ type: SearchTypes) {
        self.searchType = type
    }
    
    func searchBooks(_ query: String) {
        let typeString: String! = (self.searchType! == .all ? "q=" : "\(searchType.rawValue)=")
        guard let url = URL(string: "https://openlibrary.org/search.json?" + typeString + query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else { return }
        
        rest.makeRequest(toURL: url, withHttpMethod: .get) { response in
            if let data = response.data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let results = try? decoder.decode(SearchResults.self, from: data) else { NSLog("[SearchViewModel] Error: couldn't decode JSON"); return }
                self.model.setSearchResultData(results.docs!)
                self.setCoverImages(forBookdata: Array(results.docs!.prefix(10)), size: .M)
            }
        }
    }
    
    func setCoverImages(forBookdata data: [BookData], size: CoverImageSizes) {
        for i in 0..<data.count {
            guard let id = data[i].coverI else {
                if i == (data.count-1) { self.searchCompleted() }
                continue
            }
            if let coverImage = retrieveCoverImage(forID: id, size: size) {
                model.setCoverImage(id, image: coverImage)
                print("set cover image")
                if i == (data.count-1) { self.searchCompleted() }
            }
        }
    }
    
    func retrieveCoverImage(forID id: Int, size: CoverImageSizes) -> UIImage? {
        guard let url = URL(string: "https://covers.openlibrary.org/b/id/" + String(id) + "-" + size.rawValue + ".jpg") else { return nil }
        
        var coverImage: UIImage?
        rest.makeRequest(toURL: url, withHttpMethod: .get) { response in
            if let data = response.data, response.error == nil {
                guard let image = UIImage(data: data) else { return }
                coverImage = image
                print("got image!")
            }
        }
        return coverImage
    }
    
    private func searchCompleted() {
        DispatchQueue.main.async {
            self.searchComplete?(self.model.getBookDisplays())
        }
    }

}
