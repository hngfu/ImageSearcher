//
//  ImageSearchViewController.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/21.
//

import RxSwift
import RxCocoa
import RxDataSources

final class ImageSearchViewController: UIViewController, Storyboarded, ViewModelBindable {
    
    weak var imageSearchBar: UISearchBar?
    @IBOutlet weak var searchedImageCollectionView: UICollectionView!
    @IBOutlet weak var noSearchView: UIView!
    
    var viewModel: ImageSearchViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        bind()
    }
    
    func bind() {
        bindForImageSearchBar()
        bindForSearchedImageCollectionView()
        bindForNoSearchView()
    }
    
    //MARK: - Private
    private let disposeBag = DisposeBag()
    private let imageManager = ImageManager()
    
    private func configureViews() {
        configureSearchBar()
        configureSearchedImageCollectionView()
    }
    
    //MARK: - Configure
    private func configureSearchBar() {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Word"
        imageSearchBar = searchBar
        let searchBarWrappedView = SearchBarWrappedView(searchBar: searchBar)
        searchBarWrappedView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 44)
        navigationItem.titleView = searchBarWrappedView
        imageSearchBar?.becomeFirstResponder()
    }
    
    private func configureSearchedImageCollectionView() {
        searchedImageCollectionView.keyboardDismissMode = .onDrag
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let sideLength = searchedImageCollectionView.bounds.width / 3
        layout.itemSize = CGSize(width: sideLength, height: sideLength)
        searchedImageCollectionView.collectionViewLayout = layout
    }
    
    //MARK: - Bind
    private func bindForImageSearchBar() {
        let scheduler = SerialDispatchQueueScheduler(internalSerialQueueName: "delayAutoSearch")
        imageSearchBar?.rx.text
            .distinctUntilChanged()
            .debounce(.seconds(1), scheduler: scheduler)
            .subscribe(onNext: { [weak self] text in
                guard let text = text, (text.isEmpty == false) else { return }
                self?.viewModel?.search(word: text)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindForSearchedImageCollectionView() {
        viewModel?.searchedImageInfoRelay.asDriver(onErrorJustReturn: [])
            .map({ [SearchedImageSectionModel(model: "", items: $0)] })
            .drive(searchedImageCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel?.offsetTopRelay.asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                self?.searchedImageCollectionView.setContentOffset(.zero, animated: false)
            })
            .disposed(by: disposeBag)
        
        searchedImageCollectionView.rx.didScroll
            .map { [weak self] () -> Bool in
                guard let collectionView = self?.searchedImageCollectionView,
                      collectionView.contentSize.height > 0 else {
                    return false
                }
                let yOffset = self?.searchedImageCollectionView.contentOffset.y ?? 0
                let margin: CGFloat = 100
                return yOffset > collectionView.contentSize.height - collectionView.bounds.height - margin
            }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] nextPageFetchable in
                guard nextPageFetchable else { return }
                self?.viewModel?.fetchNextPage()
            })
            .disposed(by: disposeBag)
        
        searchedImageCollectionView.rx.modelSelected(SearchedImageInfo.self)
            .subscribe(onNext: { [weak self] info in
                self?.viewModel?.showDetailImage(with: info)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindForNoSearchView() {
        viewModel?.searchedImageInfoRelay
            .map { $0.count != 0 }
            .distinctUntilChanged()
            .bind(to: noSearchView.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    //MARK: - DataSource
    typealias SearchedImageSectionModel = AnimatableSectionModel<String, SearchedImageInfo>
    typealias SearchedImageDataSource = RxCollectionViewSectionedAnimatedDataSource<SearchedImageSectionModel>
    
    lazy var dataSource = SearchedImageDataSource(configureCell: configureCell)

    private var configureCell: SearchedImageDataSource.ConfigureCell {
        return { [weak self] _, collectionView, indexPath, info in
            let id = ImageCollectionViewCell.identifier
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: id,
                    for: indexPath) as? ImageCollectionViewCell else {
                return UICollectionViewCell()
            }
            let url = info.thumbnailURL
            cell.imageKey = url
            self?.imageManager.image(urlString: url, completionHandler: { imagePair in
                guard cell.imageKey == imagePair.key else { return }
                DispatchQueue.main.async {
                    cell.imageView.image = imagePair.image
                }
            })
            return cell
        }
    }
}
