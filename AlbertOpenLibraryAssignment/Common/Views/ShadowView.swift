//
//  ShadowView.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 7/2/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

//

class ShadowView: UIView {

    var cornerRadius: CGFloat! = 15 {
        didSet {
            layer.cornerRadius = self.cornerRadius
            contentView.layer.cornerRadius = self.cornerRadius
        }
    }
    var shadowColor: UIColor! = UIColor.black {
        didSet {
            layer.shadowColor = self.shadowColor.cgColor
        }
    }
    var shadowRadius: CGFloat = 5 {
        didSet {
            layer.shadowRadius = self.shadowRadius
        }
    }
    var shadowOpacity: Float = 0.2 {
        didSet {
            layer.shadowOpacity = self.shadowOpacity
        }
    }
    var shadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            layer.shadowOffset = self.shadowOffset
        }
    }
    
    
    var contentView: UIView! {
        didSet {
            contentView.layer.cornerRadius = self.cornerRadius
            contentView.layer.masksToBounds = true
            contentView.isUserInteractionEnabled = true
            self.addSubview(contentView)
            contentView.constrainToParent()
        }
    }
    
    convenience init(_ baseView: UIView) {
        self.init()
        defer { contentView = baseView }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = true
        
        // set layer shadow
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = self.shadowColor.cgColor
        layer.shadowRadius = self.shadowRadius
        layer.shadowOffset = self.shadowOffset
        layer.shadowOpacity = self.shadowOpacity
        layer.cornerRadius = self.cornerRadius
        layer.masksToBounds = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
