//
//  SearchView.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/27/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class SearchView: UIView {
    
    var getCellImage: ((Int)->(UIImage?))?
    var toggleFavorite: ((BookData, Bool)->())?
    var presentDetailView: ((BookData)->())?
    var searchBooks: ((String)->())?
    var setScope: ((SearchTypes)->())?
    var dismissSelf: (()->())?
    
    var results: [BookData]! {
        didSet {
            resultsTV.results = results
        }
    }
    
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.delegate = self
        search.showsScopeBar = true
        search.showsCancelButton = true
        search.scopeButtonTitles = ["Keyword", "Title", "Author"]
        
        // formatting
        search.barStyle = UIBarStyle.default
        search.placeholder = "Search open library"
        search.translatesAutoresizingMaskIntoConstraints = false
        search.backgroundColor = .white
        search.barTintColor = Colors.customRed
        search.tintColor = .white
        search.isTranslucent = false
        
        // format textField
        search.subviews.first?.subviews.forEach { view in
            if let textField = view as? UITextField {
                textField.backgroundColor = Colors.veryLightGray
                textField.textColor = .darkGray
                textField.tintColor = .darkGray
            }
        }
        
        let cancelButtonAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)
        
        return search
    }()
    
    lazy var resultsTV: BookTableView = {
        let resultsTV = BookTableView(frame: self.bounds, style: .plain)
        resultsTV.backgroundColor = .white
        resultsTV.translatesAutoresizingMaskIntoConstraints = false
        
        // content inset so results can be viewed above keyboard when active
        resultsTV.contentInset = UIEdgeInsetsMake(0, 0, UIScreen.main.bounds.height/3, 0)
        return resultsTV
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Colors.customRed
        
        resultsTV.getCellImage = { coverID in
            self.getCellImage?(coverID)
        }
        resultsTV.toggleFavorite = { data, isFavorite in
            self.toggleFavorite?(data, isFavorite)
        }
        resultsTV.presentDetailView = { data in
            self.presentDetailView?(data)
        }
        
        addSubview(resultsTV)
        addSubview(searchBar)
        addSubviewConstraints()
        
        searchBar.becomeFirstResponder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviewConstraints() {
        
        let guide = safeAreaLayoutGuide
        
        // searchBar
        searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // resultsTV
        resultsTV.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        resultsTV.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        resultsTV.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        resultsTV.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

}

extension SearchView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // only search if text exists, most recent character is not a space
        guard searchText != "", searchText.last != " " else { return }
        searchBooks?(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismissSelf?()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            setScope?(.all)
        case 1:
            setScope?(.title)
        case 2:
            setScope?(.author)
        default:
            return
        }
        if let searchText = searchBar.text {
            searchBooks?(searchText)
        }
    }
}
