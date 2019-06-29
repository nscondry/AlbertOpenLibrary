//
//  SearchView.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/27/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class SearchView: UIView {
    
    var getCellImage: ((Int)->())?
    var toggleFavorite: ((BookData, Bool)->())?
    
    var results: [BookData]! {
        didSet {
            resultsTV.results = results
        }
    }
    
    lazy var resultsTV: ResultsTableView = {
        let resultsTV = ResultsTableView(frame: self.bounds, style: .plain)
        resultsTV.backgroundColor = .clear
        resultsTV.translatesAutoresizingMaskIntoConstraints = false
        return resultsTV
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        resultsTV.getCellImage = { coverID in
            self.getCellImage?(coverID)
        }
        resultsTV.toggleFavorite = { data, isFavorite in
            self.toggleFavorite?(data, isFavorite)
        }
        
        addSubview(resultsTV)
        addSubviewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviewConstraints() {
        // resultsTV
        resultsTV.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        resultsTV.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        resultsTV.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        resultsTV.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

}
