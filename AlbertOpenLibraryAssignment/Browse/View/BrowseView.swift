//
//  BrowseView.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 7/1/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class BrowseView: UIView {

    var getCellImage: ((Int)->())?
    var browseSubject: ((String)->())?
    var presentDetailView: ((BrowsedBookData)->())?
    var presentSearchView: (()->())?
    
    var bookCV: BookCollectionView!
    var subjectCV: SubjectCollectionView!
    private var subjectCVTopAnchor: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.contents = UIImage(named: "background")?.cgImage
        
        subjectCV = SubjectCollectionView(frame: CGRect.zero, collectionViewLayout: SubjectCollectionViewLayout())
        subjectCV.browseSubject = { subject in
            self.browseSubject?(subject)
            
            // animate old books out
            self.bookCV.animateCells(false)
        }
        
        bookCV = BookCollectionView(frame: CGRect.zero, collectionViewLayout: BookCollectionViewLayout())
        bookCV.getCellImage = { coverID in
            self.getCellImage?(coverID)
        }
        bookCV.presentDetailView = { data in
            self.presentDetailView?(data)
        }
        bookCV.scrollViewScrolled = { diff in
            self.scrollViewScrolled(diff)
        }
        
        addSubviews()
        formatSubviews()
        addSubviewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(bookCV)
        addSubview(subjectCV)
    }
    
    private func formatSubviews() {
        // subjectCV
        
        // bookCV
        bookCV.backgroundColor = .clear
        bookCV.contentInset = UIEdgeInsetsMake(90, 0, 60, 0) // 90 = 50 (subjectCVheight) + 20px + 20px (padding)
    }
    
    private func addSubviewConstraints() {
        let guide = self.layoutMarginsGuide
        
        // bookCV
        bookCV.constrainToParent()
        
        // subjectCV
        subjectCV.translatesAutoresizingMaskIntoConstraints = false
        subjectCV.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        subjectCVTopAnchor = subjectCV.topAnchor.constraint(equalTo: guide.topAnchor, constant: 20)
        subjectCVTopAnchor.isActive = true
        subjectCV.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        subjectCV.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func scrollViewScrolled(_ diff: CGFloat) {
        guard diff <= 0 else { subjectCVTopAnchor.constant = 20; return }
        subjectCVTopAnchor.constant = 20 - diff
    }
}
