//
//  SubjectCollectionView.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 7/1/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit
import ViewAnimator

class SubjectCollectionView: UICollectionView {

    var browseSubject: ((String)->())?
    
    var subjects: [String] = ["Art", "Fantasy", "Biographies", "Science", "Recipes", "Romance", "Religion", "Music", "Medicine", "Plays",  "History"]
    
    private var selectedRow: Int = 0
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        // formatting
        clipsToBounds = false
        backgroundColor = .clear
        alwaysBounceHorizontal = true
        showsHorizontalScrollIndicator = false
        isPrefetchingEnabled = false // resolves minor bug where a prefetched cell that is neither visible nor dequeued does not have its selection status reset properly upon selecting another cell
        
        delegate = self
        dataSource = self
        
        register(SubjectCollectionViewCell.self, forCellWithReuseIdentifier: "subjectCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateIn() {
        self.alpha = 1
        let cells = indexPathsForVisibleItems
            .sorted { $0.row < $1.row }
            .map { cellForItem(at: $0) }
            .compactMap { $0 }
        let fromAnimation = AnimationType.from(direction: .left, offset: 20.0)
        UIView.animate(views: cells, animations: [fromAnimation])
    }
}

extension SubjectCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subjectCell", for: indexPath) as! SubjectCollectionViewCell
        
        // format
        cell.contentView.layer.backgroundColor = UIColor.white.cgColor
        cell.contentView.layer.cornerRadius = 15
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 3)
        cell.layer.shadowRadius = 3
        cell.layer.shadowOpacity = 0.2
        cell.layer.masksToBounds = false
        
        cell.subject = subjects[indexPath.row]
        cell.row = indexPath.row
        cell.isActive = (selectedRow == indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        indexPathsForVisibleItems.forEach { indexPath in
            if let cell = cellForItem(at: indexPath) as? SubjectCollectionViewCell {
                cell.isActive = (selectedRow == indexPath.row)
            }
        }
        self.browseSubject?(subjects[indexPath.row])
    }
}
