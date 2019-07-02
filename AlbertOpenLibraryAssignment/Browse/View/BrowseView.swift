//
//  BrowseView.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 7/1/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class BrowseView: UIView {

    var getCellImage: ((Int)->(UIImage?))?
    var browseSubject: ((String)->())?
    var presentDetailView: ((BrowsedBookData)->())?
    var presentSearchView: (()->())?
    
    var bookCV: BookCollectionView!
    private var subjectCV: SubjectCollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.contents = UIImage(named: "background")?.cgImage
        
        subjectCV = SubjectCollectionView(frame: CGRect.zero, collectionViewLayout: SubjectCollectionViewLayout())
        subjectCV.browseSubject = { subject in
            self.browseSubject?(subject)
        }
        
        bookCV = BookCollectionView(frame: CGRect.zero, collectionViewLayout: BookCollectionViewLayout())
        bookCV.getCellImage = { coverID in
            self.getCellImage?(coverID)
        }
        bookCV.presentDetailView = { data in
            self.presentDetailView?(data)
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
        bookCV.contentInset = UIEdgeInsetsMake(90, 0, 20, 0) // 90 = subjectCVheight + 20px + 20px (padding)
    }
    
    private func addSubviewConstraints() {
        let guide = self.layoutMarginsGuide
        
        // bookCV
        bookCV.constrainToParent()
        
        // subjectCV
        subjectCV.translatesAutoresizingMaskIntoConstraints = false
        subjectCV.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        subjectCV.topAnchor.constraint(equalTo: guide.topAnchor, constant: 20).isActive = true
        subjectCV.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        subjectCV.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
