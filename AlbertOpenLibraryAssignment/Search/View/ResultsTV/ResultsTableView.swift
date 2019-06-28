//
//  ResultsTableView.swift
//  AlbertOpenLibraryAssignment
//
//  Created by Nick on 6/27/19.
//  Copyright © 2019 Nick. All rights reserved.
//

import UIKit

class ResultsTableView: UITableView {
    
    var results: [BookDisplay]! = [] {
        didSet {
            reloadData()
//            print(results!)
        }
    }
    
    private var selectedIndices: [Int: Bool] = [:]
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
    
}

extension ResultsTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(cellCount, results.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell") as! ResultsTableViewCell
        
//        cell.cover = results[indexPath.row].coverImage
        cell.title = results[indexPath.row].data.title!
        cell.authors = results[indexPath.row].data.authorName ?? ["Unknown Author"]
        cell.isFavorite = selectedIndices[indexPath.row] ?? false
        
        cell.toggleFavorite = { isFavorite in
            self.selectedIndices[indexPath.row] = isFavorite
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * pow(0.618, 4)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? ResultsTableViewCell {
            print("""
            ----------------
            \(cell.title!)
            \(cell.authors!)
            ----------------
            """)
        }
    }
    
    
}
