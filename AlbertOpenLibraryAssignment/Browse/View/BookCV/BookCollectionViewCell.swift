//
//  BookCollectionViewCell.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 7/1/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    var cover: UIImage! {
        didSet {
            imageView.image = cover
        }
    }
    
    var coverID: Int!
    
    private var imageView: UIImageView!
    
    private var defaultImage: UIImage = UIImage(named: "defaultCoverImage")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // init & add
        imageView = UIImageView()
        contentView.addSubview(imageView)
        
        // format
        imageView.image = self.defaultImage
        imageView.contentMode = .scaleAspectFill
        
        // constrain
        imageView.constrainToParent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cover = defaultImage
    }
    
}
