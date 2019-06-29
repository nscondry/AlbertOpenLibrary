//
//  SearchViewModel.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/27/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit
import CoreData

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
    
    var searchComplete: (([BookData]?)->())?
    
    private var model: SearchModel!
    private var rest: RestManager!
    private var searchType: SearchTypes! = .all
    
    private var managedContext: NSManagedObjectContext? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return appDelegate.persistentContainer.viewContext
        } else {
            NSLog("[SearchViewModel] Error retrieving managedContext")
            return nil
        }
    }
    
    init() {
        self.model = SearchModel()
        self.rest = RestManager()
    }
    
    //
    // MARK: - REST functions
    //
    
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
                
                // begin caching images for initial results
                Array(results.docs!.prefix(10)).forEach { book in
                    guard let id = book.coverI else { return }
                    self.getCoverImage(id, .M) {_ in }
                }
                
                // update cells
                DispatchQueue.main.async {
                    self.searchComplete?(self.model.getSearchResultData())
                }
            }
        }
    }
    
    func getCoverImage(_ id: Int, _ size: CoverImageSizes, completion: @escaping(_ coverImage: UIImage?)->()) {
        guard let url = URL(string: "https://covers.openlibrary.org/b/id/" + String(id) + "-" + size.rawValue + ".jpg") else { return }
        
        if let coverImage = model.getImage(url) {
            completion(coverImage)
        } else {
            retrieveCoverImage(fromURL: url) { coverImage in
                self.model.cacheImage(coverImage, url)
                completion(coverImage)
            }
        }
    }
    
    func retrieveCoverImage(fromURL url: URL, completion: @escaping(_ coverImage: UIImage)->()) {
        rest.makeRequest(toURL: url, withHttpMethod: .get) { response in
            if let data = response.data, response.error == nil {
                guard let coverImage = UIImage(data: data) else { return }
                completion(coverImage)
            }
        }
    }
    
    //
    // MARK: - CoreData functions
    //
    
    func setFavoriteBook(_ data: BookData) {
        
        guard let managedContext = managedContext else { return }
        
        if let favoriteBook = NSEntityDescription.entity(forEntityName: "FavoriteBook", in: managedContext) {
            
            let book = NSManagedObject(entity: favoriteBook, insertInto: managedContext)
            
            if let coverID = data.coverI {
                book.setValue(Int64(coverID), forKeyPath: "coverID")
            }
            if let editionCount = data.editionCount {
                book.setValue(Int64(editionCount), forKeyPath: "editionCount")
            }
            if let firstPublishYear = data.firstPublishYear {
                book.setValue(Int64(firstPublishYear), forKeyPath: "firstPublishYear")
            }
            if let title = data.title {
                book.setValue(title, forKeyPath: "title")
            }
            if let hasFullText = data.hasFulltext {
                book.setValue(hasFullText, forKeyPath: "hasFullText")
            }
            if let authorNames = data.authorName {
                book.setValue(authorNames, forKeyPath: "authorNames")
            }
            
            do {
                try managedContext.save()
            }
            catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
        } else {
            NSLog("Failed to instantiate userEntity")
        }
    }
}
