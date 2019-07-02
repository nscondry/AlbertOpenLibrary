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
            contentView.backgroundColor = (isActive ? Colors.customBlue : UIColor.white)
            label.textColor = (isActive ? UIColor.white : UIColor.black)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {
                self.transform = (self.isActive ? CGAffineTransform(scaleX: 0.9, y: 0.9) : CGAffineTransform.identity)
            }, completion: nil)
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
