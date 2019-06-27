//
//  SearchView.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/27/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class SearchView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .blue
        
        print("searchView was initialized")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
