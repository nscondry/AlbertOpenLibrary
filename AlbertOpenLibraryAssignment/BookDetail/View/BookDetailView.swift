//
//  BookDetailView.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/30/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class BookDetailView: UIView {

    var getCoverImage: ((Int)->())?
    var dismissSelf: (()->())?
    
    var bookData: BookData! {
        didSet {
            
            if let coverID = bookData.coverI {
                self.getCoverImage?(coverID)
            }
            
            titleLabel.text = bookData.title
            
            authorLabel.text = bookData.authorName?.joined(separator: ", ") ?? "Unknown Author"
            
            if let firstPublishYear = bookData.firstPublishYear {
                publishLabel.text = String("First published: \(firstPublishYear)")
            }
            
            if let editionCount = bookData.editionCount {
                editionLabel.text = String("Edition number: \(editionCount)")
            }
            
            if let hasFulltext = bookData.hasFulltext {
                fullTextLabel.text = hasFulltext ? "Full text available" : "Full text not available"
            }
        }
    }
    
    var cover: UIImage! {
        didSet {
            self.coverImage.image = cover
        }
    }
    
    var isFavorite: Bool!
    
    var defaultImage: UIImage = UIImage(named: "defaultCoverImage")!
    
    private var xButton: UIButton!
    private var coverImage: UIImageView!
    private var titleLabel: UILabel!
    private var authorLabel: UILabel!
    private var publishLabel: UILabel!
    private var editionLabel: UILabel!
    private var fullTextLabel: UILabel!
    private var wishlistButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        xButton = UIButton()
        coverImage = UIImageView()
        titleLabel = UILabel()
        authorLabel = UILabel()
        publishLabel = UILabel()
        editionLabel = UILabel()
        fullTextLabel = UILabel()
        wishlistButton = UIButton()
        
        addSubviews()
        formatSubviews()
        addSubviewConstraints()
        addSubviewFunctions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(xButton)
        addSubview(coverImage)
        addSubview(titleLabel)
        addSubview(authorLabel)
        addSubview(publishLabel)
        addSubview(editionLabel)
        addSubview(fullTextLabel)
        addSubview(wishlistButton)
    }
    
    private func formatSubviews() {
        // xButton
        xButton.setImage(UIImage(named: "xIcon"), for: .normal)
        xButton.contentMode = .scaleAspectFit
        
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
        
        // publishLabel
        publishLabel.font = UIFont.systemFont(ofSize: 12)
        publishLabel.textColor = .lightGray
        publishLabel.adjustsFontSizeToFitWidth = true
        publishLabel.minimumScaleFactor = 0.5
        
        // editionLabel
        editionLabel.font = UIFont.systemFont(ofSize: 12)
        editionLabel.textColor = .lightGray
        editionLabel.adjustsFontSizeToFitWidth = true
        editionLabel.minimumScaleFactor = 0.5
        
        // fullTextLabel
        fullTextLabel.font = UIFont.systemFont(ofSize: 12)
        fullTextLabel.textColor = .lightGray
        fullTextLabel.adjustsFontSizeToFitWidth = true
        fullTextLabel.minimumScaleFactor = 0.5
        
        // wishlistButton
        wishlistButton.setTitle("Add to wishlist", for: .normal)
        wishlistButton.backgroundColor = .green
        wishlistButton.layer.cornerRadius = Constants.buttonHeight/2
        wishlistButton.layer.masksToBounds = true
    }
    
    private func addSubviewConstraints() {
        // xButton
        xButton.translatesAutoresizingMaskIntoConstraints = false
        xButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        xButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        xButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        xButton.widthAnchor.constraint(equalTo: xButton.heightAnchor).isActive = true
        
        // coverImage
        coverImage.translatesAutoresizingMaskIntoConstraints = false
        coverImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        coverImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        coverImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: pow(0.618, 3)).isActive = true
        coverImage.widthAnchor.constraint(equalTo: coverImage.heightAnchor, multiplier: 0.618).isActive = true
        
        // titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: coverImage.bottomAnchor, constant: 20).isActive = true
        
        // publishLabel
        publishLabel.translatesAutoresizingMaskIntoConstraints = false
        publishLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        publishLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        
        // editionLabel
        editionLabel.translatesAutoresizingMaskIntoConstraints = false
        editionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        editionLabel.topAnchor.constraint(equalTo: publishLabel.bottomAnchor, constant: 20).isActive = true
        
        // fullTextLabel
        fullTextLabel.translatesAutoresizingMaskIntoConstraints = false
        fullTextLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        fullTextLabel.topAnchor.constraint(equalTo: editionLabel.bottomAnchor, constant: 20).isActive = true
        
        // wishlistButton
        wishlistButton.translatesAutoresizingMaskIntoConstraints = false
        wishlistButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        wishlistButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Constants.bottomPadding).isActive = true
        wishlistButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
        wishlistButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40).isActive = true
    }
    
    private func addSubviewFunctions() {
        xButton.addTarget(self, action: #selector(xTapped), for: .touchUpInside)
        
        wishlistButton.addTarget(self, action: #selector(wishBtnTapped), for: .touchUpInside)
    }
    
    @objc private func xTapped() {
        self.dismissSelf?()
    }
    
    @objc private func wishBtnTapped() {
        wishlistButton.bounce()
    }
    
}
