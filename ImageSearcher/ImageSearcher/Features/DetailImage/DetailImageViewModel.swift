//
//  DetailImageViewModel.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/23.
//

import Foundation

protocol DetailImageViewModelDelegate: AnyObject {
    
}

final class DetailImageViewModel {
    
    weak var delegate: DetailImageViewModelDelegate?
    
    init(info: SearchedImageInfo) {
        
    }
}
