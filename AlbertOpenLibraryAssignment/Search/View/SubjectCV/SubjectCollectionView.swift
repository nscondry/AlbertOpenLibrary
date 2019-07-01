//
//  SubjectCollectionView.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 7/1/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class SubjectCollectionView: UICollectionView {

    var subjects: [String] = ["Art", "Fantasy", "Biographies", "Science", "Recipes", "Romance"]
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        // formatting
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
    
}

extension SubjectCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subjectCell", for: indexPath) as! SubjectCollectionViewCell
        
        cell.subject = subjects[indexPath.row]
        cell.isActive = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 50)
    }
    
    
}
