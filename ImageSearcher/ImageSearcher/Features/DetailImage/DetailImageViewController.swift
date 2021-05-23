//
//  DetailImageViewController.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/23.
//

import RxSwift

final class DetailImageViewController: UIViewController, Storyboarded, ViewModelBindable {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var siteNameLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    var viewModel: DetailImageViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel?.detailImageFinish()
    }
    
    func bind() {
        viewModel?.searchedImageInfoRelay.asDriver()
            .drive(onNext: { [weak self] info in
                guard let `self` = self else { return }
                self.siteNameLabel.isHidden = (info.siteName.count == 0) ? true : false
                self.siteNameLabel.text = "출처: \(info.siteName)"
                
                self.dateTimeLabel.isHidden = (info.dateTime.count == 0) ? true : false
                self.dateTimeLabel.text = "작성 시간: \(info.dateTime)"
                
                let height = (Int(self.imageView.bounds.width) * info.height) / info.width
                self.imageViewHeightConstraint.constant = CGFloat(height)
                
                self.imageManager.image(urlString: info.imageURL) { (_, image) in
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    //MARK: - Private
    private let disposeBag = DisposeBag()
    private let imageManager = ImageManager()
}
