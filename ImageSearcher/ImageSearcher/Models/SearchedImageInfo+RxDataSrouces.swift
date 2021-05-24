//
//  SearchedImageInfo+RxDataSrouces.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/24.
//

import RxDataSources

extension SearchedImageInfo: IdentifiableType {
    var identity: String {
        thumbnailURL
    }
}

extension SearchedImageInfo: Equatable {
    static func == (lhs: SearchedImageInfo, rhs: SearchedImageInfo) -> Bool {
        lhs.identity == rhs.identity
    }
}
