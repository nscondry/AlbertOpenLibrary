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
            UIView.animate(withDuration: 0.2) {
                self.underline.alpha = (self.isActive ? 1 : 0)
            }
        }
    }
    
    private var lineHeight: CGFloat = 2
    
    private var label: UILabel!
    private var underline: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel()
        underline = UIView()
        
        addSubviews()
        formatSubviews()
        addSubviewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(label)
        addSubview(underline)
    }
    
    private func formatSubviews() {
        // label
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        
        // underline
        underline.alpha = 0
        underline.backgroundColor = Colors.customGreen
        underline.layer.cornerRadius = lineHeight/2
        underline.layer.masksToBounds = true
    }
    
    private func addSubviewConstraints() {
        // label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        // underline
        underline.translatesAutoresizingMaskIntoConstraints = false
        underline.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        underline.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5).isActive = true
        underline.widthAnchor.constraint(equalTo: label.widthAnchor, multiplier: 0.618).isActive = true
        underline.heightAnchor.constraint(equalToConstant: lineHeight).isActive = true
    }
}
