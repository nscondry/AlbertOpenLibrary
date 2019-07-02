//
//  BookTableFooterView.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 7/2/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class BookTableFooterView: UIView {
    
    var loadMoreResults: (()->())?

    lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        lbl.textColor = .darkGray
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        addSubviewConstraints()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(cellTap))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviewConstraints() {
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40).isActive = true
    }
    
    @objc private func cellTap() {
        loadMoreResults?()
    }
    
}
