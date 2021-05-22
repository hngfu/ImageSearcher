//
//  ImageSearchManager.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/22.
//

import Foundation

final class ImageSearchManager {
    
    func search(word: String,
                successHandler: ((SearchedImageResults) -> Void)?,
                failureHandler: ((Error) -> Void)?) {
        
        searchWord = word
        currentPage = 1
        networkManager.get(url: imageSearchEndPoint,
                           parameters: parameters,
                           headers: headers,
                           successHandler: successHandler,
                           failureHandler: failureHandler)
    }
    
    func fetchNextPage(successHandler: ((SearchedImageResults) -> Void)?,
                  failureHandler: ((Error) -> Void)?) {
        
        currentPage += 1
        networkManager.get(url: imageSearchEndPoint,
                           parameters: parameters,
                           headers: headers,
                           successHandler: successHandler,
                           failureHandler: failureHandler)
    }

    //MARK: - Private
    private let networkManager = NetworkManager()
    private let imageSearchEndPoint = "https://dapi.kakao.com/v2/search/image"
    private var searchWord = String()
    private var currentPage = Int()
    private let size = 30
    
    private var parameters: [String: Any] {
        ["query": searchWord,
         "page": currentPage,
         "size": size]
    }
    private var headers: [String: String] {
        ["Authorization": "KakaoAK \(Private.apiKey)"]
    }
}
