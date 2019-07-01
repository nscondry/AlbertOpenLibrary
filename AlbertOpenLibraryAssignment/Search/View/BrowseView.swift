//
//  BrowseView.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 7/1/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class BrowseView: UIView {

    private var containerScrollView: UIScrollView!
    private var subjectCV: SubjectCollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        containerScrollView = UIScrollView()
        subjectCV = SubjectCollectionView(frame: CGRect.zero, collectionViewLayout: SubjectCollectionViewLayout())
        
        addSubviews()
        formatSubviews()
        addSubviewConstraints()
        addSubviewFunctions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(containerScrollView)
        containerScrollView.addSubview(subjectCV)
    }
    
    private func formatSubviews() {
        // containerScrollView
        containerScrollView.alwaysBounceVertical = true
        
        // subjectCV
    }
    
    private func addSubviewConstraints() {
        // containerScrollView
        containerScrollView.constrainToParent()
        
        // subjectCV
        subjectCV.translatesAutoresizingMaskIntoConstraints = false
        subjectCV.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        subjectCV.topAnchor.constraint(equalTo: containerScrollView.topAnchor, constant: 20).isActive = true
        subjectCV.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        subjectCV.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func addSubviewFunctions() {
        
    }
    
}
