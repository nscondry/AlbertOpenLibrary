//
//  ResultsTableView.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/27/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class BookTableView: UITableView {
    
    var getCellImage: ((Int)->(UIImage?))?
    var toggleFavorite: ((BookData, Bool)->())?
    var presentDetailView: ((BookData)->())?
    
    var results: [BookData]! = [] {
        didSet {
            reloadData()
        }
    }
    
    var favoriteKeys: [String] = [] // tracks selection status
    private var cellCount: Int = 10 {
        didSet {
            reloadData()
        }
    }

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        separatorColor = .clear
        showsVerticalScrollIndicator = false
        
        delegate = self
        dataSource = self
        
        register(BookTableViewCell.self, forCellReuseIdentifier: "resultCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellImage(_ id: Int, _ coverImage: UIImage) {
        visibleCells.forEach { cell in
            guard let cell = cell as? BookTableViewCell, cell.coverID == id else { return }
            cell.cover = coverImage
        }
    }
    
    func setFavorite(forBooData data: BookData) {
        visibleCells.forEach { cell in
            guard let cell = cell as? BookTableViewCell, cell.data == data else { return }
            cell.isFavorite = true
        }
    }
    
    private func loadMoreResults() {
        if results.count > cellCount {
            cellCount = cellCount + 10
        }
    }
}

extension BookTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(cellCount, results.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell") as! BookTableViewCell
        
        cell.data = results[indexPath.row]
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
        self.presentDetailView?(results[indexPath.row])
    }
    
    //
    // MARK: - Footer functions
    //
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = BookTableFooterView()
        if results.count > cellCount {
            footer.label.text = "Load more rows..."
            footer.loadMoreResults = self.loadMoreResults
            return footer
        } else if results.count == 0 {
            footer.label.text = "No results..."
            footer.label.textColor = .lightGray
            return footer
        } else {
            footer.label.text = nil
            return footer
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Constants.buttonHeight
    }
}
