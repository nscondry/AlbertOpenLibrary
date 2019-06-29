//
//  WishlistViewModel.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/28/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit
import CoreData

class WishlistViewModel {
    
    var favoriteBooksSet: (([BookData]?)->())?
    
    private var model: WishlistModel!
    
    private var managedContext: NSManagedObjectContext? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return appDelegate.persistentContainer.viewContext
        } else {
            NSLog("[SearchViewModel] Error retrieving managedContext")
            return nil
        }
    }
    
    init() {
        self.model = WishlistModel()
    }
    
    func retrieveFavoriteBooks(_ completion: @escaping(([BookData]?)->())) {
        
        guard let managedContext = managedContext else { return }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteBook")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            let bookData = (result as! [NSManagedObject]).map { BookData(fromManagedObject: $0) }
            self.model.setFavoriteBooks(bookData)
            completion(self.model.getFavoriteBooks())
        } catch {
            print("failed...")
        }
    }
}
