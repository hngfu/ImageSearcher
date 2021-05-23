//
//  DetailImageViewModel.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/23.
//

import RxRelay

protocol DetailImageViewModelDelegate: AnyObject {
    func detailImageDidFinish()
}

final class DetailImageViewModel {
    
    weak var delegate: DetailImageViewModelDelegate?
    
    let searchedImageInfoRelay: BehaviorRelay<SearchedImageInfo>
    
    func detailImageFinish() {
        delegate?.detailImageDidFinish()
    }
    
    //MARK: - Init
    init(info: SearchedImageInfo) {
        searchedImageInfoRelay = BehaviorRelay<SearchedImageInfo>(value: info)
    }
}
