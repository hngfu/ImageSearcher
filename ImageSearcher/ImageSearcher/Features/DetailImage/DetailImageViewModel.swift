//
//  DetailImageViewModel.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/23.
//

import RxRelay

protocol DetailImageViewModelDelegate: AnyObject {
    
}

final class DetailImageViewModel {
    
    weak var delegate: DetailImageViewModelDelegate?
    
    let searchedImageInfoRelay: BehaviorRelay<SearchedImageInfo>
    
    //MARK: - Init
    init(info: SearchedImageInfo) {
        searchedImageInfoRelay = BehaviorRelay<SearchedImageInfo>(value: info)
    }
}
