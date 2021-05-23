//
//  SearchBarWrappedView.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/24.
//

import UIKit

final class SearchBarWrappedView: UIView {
    
    private let searchBar: UISearchBar
    
    init(searchBar: UISearchBar) {
        self.searchBar = searchBar
        
        super.init(frame: .zero)
        addSubview(searchBar)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        searchBar.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
