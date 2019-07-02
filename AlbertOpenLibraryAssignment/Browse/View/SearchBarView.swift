//
//  SearchView.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 7/1/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class SearchBarView: UIView {

    private var contentView: UIView!
    private var searchIcon: UIImageView!
    private var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView = UIView()
        searchIcon = UIImageView()
        label = UILabel()
        
        addSubviews()
        formatSubviews()
        addSubviewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(contentView)
        contentView.addSubview(searchIcon)
        contentView.addSubview(label)
    }
    
    private func formatSubviews() {
        // contentView
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        
        // searchIcon
        searchIcon.alpha = 0.5
        searchIcon.image = UIImage(named: "searchIcon")
        searchIcon.contentMode = .scaleAspectFit
        
        // label
        label.text = "Search by author, title, keyword..."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
    }
    
    private func addSubviewConstraints() {
        // contentView
        contentView.constrainToParent()
        
        // searchIcon
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        searchIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        searchIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        searchIcon.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.618).isActive = true
        searchIcon.widthAnchor.constraint(equalTo: searchIcon.widthAnchor).isActive = true
        
        // label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 20).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
