//
//  BookTableViewCell.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/27/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var toggleFavorite: ((Bool)->())?
    
    var data: BookData! {
        didSet {
            if let title = data.title { titleLabel.text = title }
            authorLabel.text = data.authorName?.joined(separator: ", ") ?? defaultAuthorName
        }
    }
    
    var cover: UIImage? {
        didSet {
            coverImage?.image = cover
        }
    }
    
    var isFavorite: Bool! {
        didSet {
            heartIcon.image = UIImage(named: (isFavorite ? "favoriteIcon_selected" : "favoriteIcon"))
        }
    }
    
    var key: String? { return data.key }
    var coverID: Int? { return data.coverI }
    
    private var defaultImage: UIImage = UIImage(named: "defaultCoverImage")!
    private var defaultAuthorName: String =  "Unknown Author"
    
    private var coverImage: UIImageView!
    private var titleLabel: UILabel!
    private var authorLabel: UILabel!
    private var labelStack: UIStackView!
    private var heartIcon: UIImageView!
    private var moreIcon: UIImageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        coverImage = UIImageView()
        titleLabel = UILabel()
        authorLabel = UILabel()
        labelStack = UIStackView(arrangedSubviews: [titleLabel, authorLabel])
        heartIcon = UIImageView()
        moreIcon = UIImageView()
        
        addSubviews()
        formatSubviews()
        addSubviewConstraints()
        addSubviewFunctions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImage.image = defaultImage
    }
    
    private func addSubviews() {
        addSubview(coverImage)
        addSubview(labelStack)
        addSubview(heartIcon)
        addSubview(moreIcon)
    }
    
    private func formatSubviews() {
        // coverImage
        coverImage.image = defaultImage
        coverImage.contentMode = .scaleAspectFill
        coverImage.layer.cornerRadius = 5
        coverImage.layer.masksToBounds = true
        
        // titleLabel
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        
        // authorLabel
        authorLabel.font = UIFont.systemFont(ofSize: 12)
        authorLabel.textColor = .lightGray
        authorLabel.adjustsFontSizeToFitWidth = true
        authorLabel.minimumScaleFactor = 0.5
        
        // labelStack
        labelStack.axis = .vertical
        labelStack.alignment = .leading
        labelStack.distribution = .fillEqually
        
        // heartIcon
        heartIcon.isUserInteractionEnabled = true
        heartIcon.image = UIImage(named: "favoriteIcon")
        heartIcon.contentMode = .scaleAspectFit
        
        // moreIcon
        moreIcon.image = UIImage(named: "moreIcon")
        moreIcon.contentMode = .scaleAspectFit
    }
    
    private func addSubviewConstraints() {
        // coverImage
        coverImage.translatesAutoresizingMaskIntoConstraints = false
        coverImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        coverImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        coverImage.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -40).isActive = true
        coverImage.widthAnchor.constraint(equalTo: coverImage.heightAnchor, multiplier: 0.618).isActive = true
        
        // labelStack
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        labelStack.leadingAnchor.constraint(equalTo: coverImage.trailingAnchor, constant: 20).isActive = true
        labelStack.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        labelStack.heightAnchor.constraint(equalTo: coverImage.heightAnchor).isActive = true
        labelStack.trailingAnchor.constraint(equalTo: heartIcon.leadingAnchor, constant: -20).isActive = true
        
        // heartIcon
        heartIcon.translatesAutoresizingMaskIntoConstraints = false
        heartIcon.trailingAnchor.constraint(equalTo: moreIcon.leadingAnchor, constant: -20).isActive = true
        heartIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        heartIcon.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: pow(0.618, 2.5)).isActive = true
        heartIcon.widthAnchor.constraint(equalTo: heartIcon.heightAnchor).isActive = true
        
        // moreIcon
        moreIcon.translatesAutoresizingMaskIntoConstraints = false
        moreIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        moreIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        moreIcon.heightAnchor.constraint(equalTo: heartIcon.heightAnchor, multiplier: pow(0.618, 2)).isActive = true
        moreIcon.widthAnchor.constraint(equalTo: moreIcon.heightAnchor).isActive = true
    }
    
    private func addSubviewFunctions() {
        let favTap = UITapGestureRecognizer(target: self, action: #selector(favoriteTapped))
        heartIcon.addGestureRecognizer(favTap)
    }
    
    @objc private func favoriteTapped() {
        heartIcon.bounce()
        self.isFavorite.toggle()
        self.toggleFavorite?(self.isFavorite)
    }
}
