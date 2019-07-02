//
//  BookCollectionView.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 7/1/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class BookCollectionView: UICollectionView {

    var getCellImage: ((Int)->(UIImage?))?
    var pushDetailView: ((BrowsedBookData)->())?
    
    var books: [BrowsedBookData]! = [] {
        didSet {
            self.reloadData()
        }
    }
    
    private var cellWidth: CGFloat {
        // 2 columns, 20 px padding in left, right, center (60 total)
        return (UIScreen.main.bounds.width - 60) / 2
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        // formatting
        self.clipsToBounds = false
        self.backgroundColor = .clear
        alwaysBounceVertical = true
        showsVerticalScrollIndicator = false
        
        delegate = self
        dataSource = self
        
        register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "bookCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCellImage(_ id: Int, _ coverImage: UIImage) {
        visibleCells.forEach { cell in
            guard let cell = cell as? BookCollectionViewCell, cell.coverID == id else { return }
            cell.cover = coverImage
        }
    }
}

extension BookCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(10, books.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as! BookCollectionViewCell
        
        cell.coverID = books[indexPath.row].coverId
        cell.title = books[indexPath.row].title
        
        cell.contentView.layer.backgroundColor = UIColor.white.cgColor
        cell.contentView.layer.cornerRadius = 15
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 3)
        cell.layer.shadowRadius = 3
        cell.layer.shadowOpacity = 0.2
        cell.layer.masksToBounds = false
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellWidth * 1.618)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected cell")
    }
    
    // get cover image once cell is displayed
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? BookCollectionViewCell {
            self.getCellImage?(cell.coverID)
        }
    }
}
