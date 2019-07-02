//
//  BookDetailView.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/30/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit
import ViewAnimator

class BookDetailView: UIView {

    var getCoverImage: ((Int)->())?
    var dismissSelf: (()->())?
    var toggleFavorite: ((BookData, Bool)->())?
    
    // bookData is set immediately
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
    
    // cover is set asynchronously
    var cover: UIImage! {
        didSet {
            self.coverImage.image = cover
        }
    }
    
    var isFavorite: Bool! {
        didSet {
            if isFavorite {
                wishlistButton.setTitle("Remove from wishlist", for: .normal)
                wishlistButton.backgroundColor = Colors.customRed
            } else {
                wishlistButton.setTitle("Add to wishlist", for: .normal)
                wishlistButton.backgroundColor = Colors.customGreen
            }
        }
    }
    var defaultImage: UIImage = UIImage(named: "defaultCoverImage")!
    
    private var blurBackground: UIVisualEffectView!
    private var cardBackground: UIView!
    private var cardShadow: ShadowView!
    private var cardTopConstraint: NSLayoutConstraint!
    private var xButton: UIButton!
    private var coverImage: UIImageView!
    private var coverShadow: ShadowView!
    private var titleLabel: UILabel!
    private var authorLabel: UILabel!
    private var publishLabel: UILabel!
    private var editionLabel: UILabel!
    private var fullTextLabel: UILabel!
    private var wishlistButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.contents = UIImage(named: "background")?.cgImage
        
        blurBackground = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.extraLight))
        cardBackground = UIView()
        cardShadow = ShadowView(cardBackground)
        xButton = UIButton()
        coverImage = UIImageView()
        coverShadow = ShadowView(coverImage)
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
        addSubview(blurBackground)
        addSubview(cardShadow)
        addSubview(xButton)
        addSubview(coverShadow)
        addSubview(titleLabel)
        addSubview(authorLabel)
        addSubview(publishLabel)
        addSubview(editionLabel)
        addSubview(fullTextLabel)
        addSubview(wishlistButton)
    }
    
    private func formatSubviews() {
        // blurBackground
        
        // cardBackground
        cardBackground.backgroundColor = .white
        cardBackground.layer.cornerRadius = 15
        cardBackground.layer.masksToBounds = true
        
        // cardShadow
        coverShadow.shadowOffset = CGSize(width: 0, height: 3)
        
        // xButton
        xButton.setImage(UIImage(named: "xIcon"), for: .normal)
        xButton.contentMode = .scaleAspectFit
        
        // coverImage
        coverImage.alpha = 0
        coverImage.image = defaultImage
        coverImage.contentMode = .scaleAspectFill
        coverImage.layer.cornerRadius = 15
        coverImage.layer.masksToBounds = true
        
        // coverShadow
        coverShadow.alpha = 0
        coverShadow.shadowOffset = CGSize(width: 0, height: 3)
        
        // titleLabel
        titleLabel.alpha = 0
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.textAlignment = .center
        
        // authorLabel
        authorLabel.alpha = 0
        authorLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        authorLabel.textColor = .lightGray
        authorLabel.numberOfLines = 2
        authorLabel.lineBreakMode = .byWordWrapping
        authorLabel.adjustsFontSizeToFitWidth = true
        authorLabel.minimumScaleFactor = 0.5
        authorLabel.textAlignment = .center
        
        // publishLabel
        publishLabel.alpha = 0
        publishLabel.font = UIFont.systemFont(ofSize: 12)
        publishLabel.textColor = .lightGray
        publishLabel.adjustsFontSizeToFitWidth = true
        publishLabel.minimumScaleFactor = 0.5
        
        // editionLabel
        editionLabel.alpha = 0
        editionLabel.font = UIFont.systemFont(ofSize: 12)
        editionLabel.textColor = .lightGray
        editionLabel.adjustsFontSizeToFitWidth = true
        editionLabel.minimumScaleFactor = 0.5
        
        // fullTextLabel
        fullTextLabel.alpha = 0
        fullTextLabel.font = UIFont.systemFont(ofSize: 12)
        fullTextLabel.textColor = .lightGray
        fullTextLabel.adjustsFontSizeToFitWidth = true
        fullTextLabel.minimumScaleFactor = 0.5
        
        // wishlistButton
        wishlistButton.alpha = 0
        wishlistButton.setTitle("Add to wishlist", for: .normal)
        wishlistButton.backgroundColor = Colors.customGreen
        wishlistButton.layer.cornerRadius = 15
        wishlistButton.layer.masksToBounds = true
    }
    
    private func addSubviewConstraints() {
        // blurBackground
        blurBackground.constrainToParent()
        
        // cardShadow
        cardShadow.translatesAutoresizingMaskIntoConstraints = false
        cardShadow.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        cardTopConstraint = cardShadow.topAnchor.constraint(equalTo: self.bottomAnchor)
        cardTopConstraint.isActive = true
        cardShadow.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75).isActive = true
        cardShadow.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        // xButton
        xButton.translatesAutoresizingMaskIntoConstraints = false
        xButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        xButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        xButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        xButton.widthAnchor.constraint(equalTo: xButton.heightAnchor).isActive = true
        
        // coverShadow
        coverShadow.translatesAutoresizingMaskIntoConstraints = false
        coverShadow.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        coverShadow.centerYAnchor.constraint(equalTo: cardShadow.topAnchor).isActive = true
        coverShadow.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: pow(0.618, 2.5)).isActive = true
        coverShadow.widthAnchor.constraint(equalTo: coverImage.heightAnchor, multiplier: 0.618).isActive = true
        
        // authorLabel
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        authorLabel.topAnchor.constraint(equalTo: coverImage.bottomAnchor, constant: 40).isActive = true
        authorLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-40).isActive = true
        
        // titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 20).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-40).isActive = true
        
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
        wishlistButton.bottomAnchor.constraint(equalTo: cardShadow.bottomAnchor, constant: Constants.bottomPadding).isActive = true
        wishlistButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
        wishlistButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-40).isActive = true
    }
    
    private func addSubviewFunctions() {
        xButton.addTarget(self, action: #selector(dismissTap), for: .touchUpInside)
        
        // also dismiss if user taps blurBackground -- makes it easy to select
        let backgroundTap = UITapGestureRecognizer(target: self, action: #selector(dismissTap))
        self.blurBackground.addGestureRecognizer(backgroundTap)
        
        wishlistButton.addTarget(self, action: #selector(wishBtnTapped), for: .touchUpInside)
    }
    
    //
    // MARK: - Button Actions
    //
    
    @objc private func dismissTap() {
        self.dismissSelf?()
    }
    
    @objc private func wishBtnTapped() {
        wishlistButton.bounce()
        isFavorite.toggle()
        toggleFavorite?(bookData, isFavorite)
    }
    
    //
    // MARK: - Animations
    //
    
    func animateIn() {
        let views: [UIView] = [coverShadow, authorLabel, titleLabel, publishLabel, editionLabel, fullTextLabel, wishlistButton]
        let fromAnimation = AnimationType.from(direction: .bottom, offset: 30.0)
        
        // animate card in, then views
        self.cardTopConstraint.constant = -cardShadow.bounds.height
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            // animate card
            self.layoutIfNeeded()
        }) { (complete) in
            
            // reveal views
            views.forEach { view in
                view.alpha = 1
            }
            self.coverImage.alpha = 1 // will inherit animation, but not alpha from coverShadow
            
            // animate views
            UIView.animate(views: views, animations: [fromAnimation], reversed: false, initialAlpha: 0, finalAlpha: 1, delay: 0, animationInterval: 0.1, duration: 0.3, options: .curveEaseInOut, completion: nil)
        }
    }
}
