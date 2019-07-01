//
//  ResultsTableView.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/27/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class ResultsTableView: UITableView {
    
    var getCellImage: ((Int)->(UIImage?))?
    var toggleFavorite: ((BookData, Bool)->())?
    var pushDetailView: ((BookData)->())?
    
    var results: [BookData]! = [] {
        didSet {
            reloadData()
        }
    }
    
    var favoriteKeys: [String] = [] // tracks selection status
    private var cellCount: Int = 10

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.separatorColor = .clear
        self.showsVerticalScrollIndicator = false
        
        delegate = self
        dataSource = self
        
        register(ResultsTableViewCell.self, forCellReuseIdentifier: "resultCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellImage(_ id: Int, _ coverImage: UIImage) {
        visibleCells.forEach { cell in
            guard let cell = cell as? ResultsTableViewCell, cell.coverID == id else { return }
            cell.cover = coverImage
        }
    }
}

extension ResultsTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(cellCount, results.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell") as! ResultsTableViewCell
        
        cell.title = results[indexPath.row].title!
        cell.authors = results[indexPath.row].authorName ?? ["Unknown Author"] // move to constant: defaultAuthorName
        cell.coverID = results[indexPath.row].coverI
        cell.key = results[indexPath.row].key
        cell.isFavorite = favoriteKeys.contains(cell.key ?? "")
        
        cell.toggleFavorite = { isFavorite in
            guard let key = cell.key else { return }
            
            if isFavorite {
                self.favoriteKeys.append(key)
            } else {
                self.favoriteKeys = self.favoriteKeys.filter { $0 != key }
            }
            self.toggleFavorite?(self.results[indexPath.row], cell.isFavorite)
        }
        
        if let id = cell.coverID, let coverImage = self.getCellImage?(id) {
            cell.cover = coverImage
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * pow(0.618, 4)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // push bookDetailViewController for selected bookData
        self.pushDetailView?(results[indexPath.row])
    }
}
