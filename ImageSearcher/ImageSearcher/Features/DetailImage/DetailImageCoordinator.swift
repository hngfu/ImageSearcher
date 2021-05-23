//
//  DetailImageCoordinator.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/23.
//

import Foundation

protocol DetailImageCoordinatorDelegate: AnyObject {
    
}

final class DetailImageCoordinator: Coordinator {
    
    weak var delegate: DetailImageCoordinatorDelegate?
    
    func start(with info: SearchedImageInfo) {
        let vc = DetailImageViewController.instantiate()
        let viewModel = DetailImageViewModel(info: info)
        viewModel.delegate = self
        self.viewModel = viewModel
        vc.viewModel = viewModel
        navigationController.isNavigationBarHidden = false
        navigationController.pushViewController(vc, animated: true)
    }
    
    //MARK: - Private
    private var viewModel: DetailImageViewModel?
}

extension DetailImageCoordinator: DetailImageViewModelDelegate {
    
}
