//
//  ImageSearchManager.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/22.
//

import Foundation

struct ImageSearchManager {
    
    func search(word: String,
                successHandler: ((SearchedImageResults) -> Void)?,
                failureHandler: ((Error) -> Void)?) {
        
        let parameters: [String: Any] =
            ["query": word,
             "page": 1,
             "size": 4,]
        let headers: [String: String] =
            ["Authorization": "KakaoAK \(Private.apiKey)"]
        networkManager.get(url: imageSearchEndPoint,
                           parameters: parameters,
                           headers: headers,
                           successHandler: successHandler,
                           failureHandler: failureHandler)
    }

    //MARK: - Private
    private let networkManager = NetworkManager()
    private let imageSearchEndPoint = "https://dapi.kakao.com/v2/search/image"
}
