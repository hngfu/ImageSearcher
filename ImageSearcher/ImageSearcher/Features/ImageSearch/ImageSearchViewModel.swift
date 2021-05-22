//
//  ImageSearchViewModel.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/21.
//

import RxRelay

final class ImageSearchViewModel {
    
    let searchedImageInfoRelay = PublishRelay<[SearchedImageInfo]>()
    
    func search(word: String) {
        imageSearchManager.search(word: word) { [weak self] searchedResults in
            guard let `self` = self else { return }
            self.nextPageFetchable = (searchedResults.meta.isEnd == false)
            self.searchedImageInfo = searchedResults.documents
            self.searchedImageInfoRelay.accept(self.searchedImageInfo)
        } failureHandler: { error in
            //TODO: add failureHandler
            print(error)
        }
    }
    
    func fetchNextPage() {
        guard nextPageFetchable else { return }
        imageSearchManager.fetchNextPage { [weak self] nextPage in
            guard let `self` = self else { return }
            self.nextPageFetchable = (nextPage.meta.isEnd) == false
            self.searchedImageInfo += nextPage.documents
            self.searchedImageInfoRelay.accept(self.searchedImageInfo)
        } failureHandler: { error in
            //TODO: add failureHandler
            print(error)
        }
    }
    
    //MARK: - Private
    private let imageSearchManager = ImageSearchManager()
    private var searchedImageInfo = [SearchedImageInfo]()
    private var nextPageFetchable = Bool()
}
