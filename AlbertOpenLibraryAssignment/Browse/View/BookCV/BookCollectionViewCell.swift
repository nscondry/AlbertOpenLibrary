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
    
    var title: String! {
        didSet {
            titleLabel.text = title
        }
    }
    
    var coverID: Int!
    
    private var defaultImage: UIImage = UIImage(named: "defaultCoverImage")!
    
    private var imageView: UIImageView!
    private var titleLabel: UILabel!
    private var gradientView: UIView!
    private var gradient: CAGradientLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        titleLabel = UILabel()
        gradientView = UIView(frame: self.bounds)
        gradient = CAGradientLayer()
        
        addSubviews()
        formatSubviews()
        addSubviewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cover = defaultImage
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard gradient.frame != gradientView.bounds else { return }
        gradient.frame = gradientView.bounds
    }
    
    private func addSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(gradientView)
        gradientView.layer.insertSublayer(gradient, at: 0)
        contentView.addSubview(titleLabel)
    }
    
    private func formatSubviews() {
        // imageView
        imageView.image = self.defaultImage
        imageView.contentMode = .scaleAspectFill
        
        // titleLabel
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        
        // gradientView
//        gradientView.alpha = 0
        
        // gradient
        gradient.opacity = 0
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.5).cgColor]
        gradient.locations = [0.0, 1.0]
    }
    
    private func addSubviewConstraints() {
        // imageView
        imageView.constrainToParent()
        
        // titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
        // gradientView
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -20).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
