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
    
    var bookCV: BookCollectionView!
    private var containerScrollView: UIScrollView! // deleteMe
    private var searchBar: SearchBarView!
    private var subjectCV: SubjectCollectionView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        containerScrollView = UIScrollView()
        searchBar = SearchBarView()
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
        addSubviewFunctions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(bookCV)
        addSubview(searchBar)
        addSubview(subjectCV)
    }
    
    private func formatSubviews() {
        // containerScrollView
        containerScrollView.layer.contents = UIImage(named: "background")?.cgImage
        containerScrollView.alwaysBounceVertical = true
        
        // searchBar
        searchBar.layer.backgroundColor = UIColor.clear.cgColor
        searchBar.layer.shadowColor = UIColor.black.cgColor
        searchBar.layer.shadowOffset = CGSize(width: 0, height: 3)
        searchBar.layer.shadowRadius = 3
        searchBar.layer.shadowOpacity = 0.2
        searchBar.layer.masksToBounds = false
        
        // subjectCV
        
        // bookCV
        bookCV.backgroundColor = .white
        bookCV.contentInset = UIEdgeInsetsMake(200, 0, 20, 0)
    }
    
    private func addSubviewConstraints() {
        // bookCV
        bookCV.constrainToParent()
        
        // searchBar
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: subjectCV.topAnchor, constant: -20).isActive = true
        searchBar.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // subjectCV
        subjectCV.translatesAutoresizingMaskIntoConstraints = false
        subjectCV.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        subjectCV.topAnchor.constraint(equalTo: bookCV.topAnchor, constant: 160).isActive = true
        subjectCV.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        subjectCV.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func addSubviewFunctions() {
        let searchTap = UITapGestureRecognizer(target: self, action: #selector(searchTapped))
        searchBar.addGestureRecognizer(searchTap)
    }
    
    @objc private func searchTapped() {
        print("searchTapped")
    }
    
}
