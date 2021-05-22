//
//  ImageSearchViewController.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/21.
//

import RxSwift
import RxCocoa

final class ImageSearchViewController: UIViewController, Storyboarded, ViewModelBindable {
    
    @IBOutlet weak var imageSearchBar: UISearchBar!
    @IBOutlet weak var searchedImageCollectionView: UICollectionView!
    @IBOutlet weak var noSearchView: UIView!
    
    var viewModel: ImageSearchViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageSearchBar.becomeFirstResponder()
        searchedImageCollectionView.keyboardDismissMode = .onDrag
        searchedImageCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        bind()
    }
    
    func bind() {
        guard let viewModel = viewModel else { return }
        
        //MARK: - imageSeachBar
        let scheduler = SerialDispatchQueueScheduler(internalSerialQueueName: "delayAutoSearch")
        imageSearchBar.rx.text
            .debounce(.seconds(1), scheduler: scheduler)
            .subscribe(onNext: { [weak self] text in
                guard let text = text else { return }
                self?.viewModel?.search(word: text)
            })
            .disposed(by: disposeBag)
        
        //MARK: - searchedImageCollectionView
        viewModel.searchedImageInfoRelay
            .bind(to: searchedImageCollectionView.rx.items(
                    cellIdentifier: ImageCollectionViewCell.identifier,
                    cellType: ImageCollectionViewCell.self)
            ) { [weak self] _, info, cell in
                
                let url = info.thumbnailURL
                cell.imageKey = url
                self?.imageManager.image(urlString: url, completionHandler: { imagePair in
                    guard cell.imageKey == imagePair.key else { return }
                    DispatchQueue.main.async {
                        cell.imageView.image = imagePair.image
                    }
                })
            }
            .disposed(by: disposeBag)
        
        viewModel.offsetTopRelay
            .bind(onNext: { [weak self] in
                self?.searchedImageCollectionView.setContentOffset(.zero, animated: false)
            })
            .disposed(by: disposeBag)
        
        searchedImageCollectionView.rx.didScroll
            .map { [weak self] () -> Bool in
                guard let collectionView = self?.searchedImageCollectionView else { return false }
                let yOffset = self?.searchedImageCollectionView.contentOffset.y ?? 0
                return yOffset > collectionView.contentSize.height - collectionView.bounds.height
            }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] nextPageFetchable in
                guard nextPageFetchable else { return }
                self?.viewModel?.fetchNextPage()
            })
            .disposed(by: disposeBag)
        
        //MARK: - noSearchView
        viewModel.searchedImageInfoRelay
            .map { $0.count != 0 }
            .distinctUntilChanged()
            .bind(to: noSearchView.rx.isHidden)
            .disposed(by: disposeBag)
            
    }
    
    //MARK: - Private
    private var disposeBag = DisposeBag()
    private let imageManager = ImageManager()
}

extension ImageSearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sideLength = UIScreen.main.bounds.width / 3
        return .init(width: sideLength, height: sideLength)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
