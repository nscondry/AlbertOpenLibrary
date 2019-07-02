//
//  SubjectCollectionViewCell.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 7/1/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class SubjectCollectionViewCell: UICollectionViewCell {
    
    var subject: String! {
        didSet {
            label.text = subject
        }
    }
    
    var isActive: Bool! {
        didSet {
            self.bounce()
        }
    }
    
    var row: Int!
    
    private var lineHeight: CGFloat = 2
    
    private var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        label = UILabel()
        
        addSubviews()
        formatSubviews()
        addSubviewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(label)
    }
    
    private func formatSubviews() {
        // label
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .black
    }
    
    private func addSubviewConstraints() {
        // label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
