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
    
    var viewModel: ImageSearchViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        guard let viewModel = viewModel else { return }
        
        let scheduler = SerialDispatchQueueScheduler(internalSerialQueueName: "delayAutoSearch")
        imageSearchBar.rx.text
            .debounce(.seconds(1), scheduler: scheduler)
            .subscribe(onNext: { text in
                guard let text = text else { return }
                print(text)
            })
            .disposed(by: disposeBag)
        
        
    }
    
    //MARK: - Private
    private var disposeBag = DisposeBag()
}
