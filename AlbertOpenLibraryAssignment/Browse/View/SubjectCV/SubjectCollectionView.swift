//
//  SubjectCollectionView.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 7/1/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class SubjectCollectionView: UICollectionView {

    var browseSubject: ((String)->())?
    
    var subjects: [String] = ["Art", "Fantasy", "Biographies", "Science", "Recipes", "Romance"]
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        // formatting
        self.clipsToBounds = false
        self.backgroundColor = .clear
        alwaysBounceHorizontal = true
        showsHorizontalScrollIndicator = false
        
        delegate = self
        dataSource = self
        
        
        register(SubjectCollectionViewCell.self, forCellWithReuseIdentifier: "subjectCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func scroll(toIndexPathPreservingLeftInset indexPath: IndexPath, animated: Bool) {
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        let sectionLeftInset = layout.sectionInset.left
        if let attri = layout.layoutAttributesForItem(at: indexPath) {
            self.setContentOffset(CGPoint(x: (attri.frame.origin.x - sectionLeftInset), y: 0), animated: animated)
            if let cell = cellForItem(at: indexPath) { cell.bounce() }
        }
    }
}

extension SubjectCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subjectCell", for: indexPath) as! SubjectCollectionViewCell
        
        cell.subject = subjects[indexPath.row]
        cell.row = indexPath.row
        cell.isActive = true
        
        // format
        cell.contentView.layer.backgroundColor = UIColor.white.cgColor
        cell.contentView.layer.cornerRadius = 5
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
        return CGSize(width: 120, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.scroll(toIndexPathPreservingLeftInset: indexPath, animated: true)
        self.browseSubject?(subjects[indexPath.row])
    }
}
