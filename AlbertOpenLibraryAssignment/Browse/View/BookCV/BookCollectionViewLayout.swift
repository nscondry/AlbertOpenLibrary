//
//  BookCollectionViewLayout.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 7/1/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class BookCollectionViewLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()
        
        // formatting
        self.scrollDirection = .vertical
        self.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20)
        minimumLineSpacing = 20
        minimumInteritemSpacing = 20
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
