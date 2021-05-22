//
//  ImageSearchViewModel.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/21.
//

import RxRelay

final class ImageSearchViewModel {
    
    let searchedImageInfoRelay = PublishRelay<[SearchedImageInfo]>()
    let offsetTopRelay = PublishRelay<Void>()
    
    func search(word: String) {
        imageSearchManager.search(word: word, successHandler: { [weak self] searchedResults in
            guard let `self` = self else { return }
            self.nextPageFetchable = (searchedResults.meta.isEnd == false)
            self.isFetchingNextPage = false
            self.searchedImageInfo = searchedResults.documents
            self.offsetTopRelay.accept(())
            self.searchedImageInfoRelay.accept(self.searchedImageInfo)
        }, failureHandler: nil)
    }
    
    func fetchNextPage() {
        guard nextPageFetchable && !isFetchingNextPage else { return }
        isFetchingNextPage = true
        imageSearchManager.fetchNextPage(successHandler: { [weak self] nextPage in
            guard let `self` = self else { return }
            self.nextPageFetchable = (nextPage.meta.isEnd) == false
            self.isFetchingNextPage = false
            self.searchedImageInfo += nextPage.documents
            self.searchedImageInfoRelay.accept(self.searchedImageInfo)
        }, failureHandler: nil)
    }
    
    //MARK: - Private
    private let imageSearchManager = ImageSearchManager()
    private var searchedImageInfo = [SearchedImageInfo]()
    private var nextPageFetchable = Bool()
    private var isFetchingNextPage = Bool()
}
