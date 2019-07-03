//
//  CoreDataManager.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 7/1/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol CoreDataManagerProtocol {
    var getImageFromURL: ((URL)->(UIImage?))? { get set }
    
    func setFavoriteBook(_ data: BookData)
    func deleteFavoriteBook(_ data: BookData)
    func getFavoriteBooks() -> [BookData]
    func getFavoriteKeys() -> [String]
    func getImage(forCoverID id: Int) -> UIImage?
}

class CoreDataManager: CoreDataManagerProtocol {
    
    var getImageFromURL: ((URL)->(UIImage?))?
    
    private var managedContext: NSManagedObjectContext? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return appDelegate.persistentContainer.viewContext
        } else {
            NSLog("[SearchViewModel] Error retrieving managedContext")
            return nil
        }
    }
    
    func setFavoriteBook(_ data: BookData) {
        
        guard let managedContext = managedContext else { return }
        
        if let favoriteBook = NSEntityDescription.entity(forEntityName: "FavoriteBook", in: managedContext) {
            
            let book = NSManagedObject(entity: favoriteBook, insertInto: managedContext)
            
            if let coverID = data.coverI {
                book.setValue(Int64(coverID), forKeyPath: "coverID")
                
                // store image data if available
                if let url = URL(string: "https://covers.openlibrary.org/b/id/" + String(coverID) + "-M.jpg"),
                    let coverImage = self.getImageFromURL?(url),
                    let data = UIImagePNGRepresentation(coverImage) {
                    book.setValue(data, forKeyPath: "coverImage")
                }
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
            if let key = data.key {
                book.setValue(key, forKey: "key")
            }
            
            do {
                try managedContext.save()
            }
            catch let error as NSError {
                NSLog("Could not save. \(error), \(error.userInfo)")
            }
            
        } else {
            NSLog("Failed to instantiate userEntity")
        }
    }
    
    func deleteFavoriteBook(_ data: BookData) {
        
        guard let managedContext = managedContext, let coverID = data.coverI else { return }
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "FavoriteBook")
        fetchRequest.predicate = NSPredicate(format: "coverID == \(coverID)")
        
        do {
            let books = try managedContext.fetch(fetchRequest)
            let objectToDelete = books[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do {
                try managedContext.save()
            }
            catch {
                NSLog("\(error)")
            }
        }
        catch {
            NSLog("\(error)")
        }
    }
    
    func getFavoriteBooks() -> [BookData] {
        
        guard let managedContext = managedContext else { return [] }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteBook")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            let bookData = (result as! [NSManagedObject]).map { BookData(fromManagedObject: $0) }
            return bookData
        } catch {
            NSLog("\(error)")
            return []
        }
    }
    
    func getFavoriteKeys() -> [String] {
        
        guard let managedContext = managedContext else { return [] }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteBook")
        
        var favoriteKeys: [String] = []
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                if let key = data.value(forKey: "key") as? String {
                    favoriteKeys.append(key)
                }
            }
        } catch {
            NSLog("\(error)")
        }
        
        return favoriteKeys
    }
    
    func getImage(forCoverID id: Int) -> UIImage? {
        
        guard let managedContext = managedContext else { return nil }
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "FavoriteBook")
        fetchRequest.predicate = NSPredicate(format: "coverID == \(id)")
        
        do {
            let books = try managedContext.fetch(fetchRequest)
            if let book = books[0] as? NSManagedObject, let imageData = book.value(forKey: "coverImage") as? NSData {
                return UIImage(data: imageData as Data, scale: 1.0)
            } else {
                return nil
            }
        }
        catch {
            NSLog("\(error)")
            return nil
        }
    }
    
}
