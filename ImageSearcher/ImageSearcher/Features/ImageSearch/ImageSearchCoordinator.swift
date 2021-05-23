//
//  ImageSearchCoordinator.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/21.
//

import UIKit

final class ImageSearchCoordinator: Coordinator {

    func start() {
        let vc = ImageSearchViewController.instantiate()
        let viewModel = ImageSearchViewModel()
        viewModel.delegate = self
        self.viewModel = viewModel
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: false)
    }
    
    //MARK: - Private
    private var viewModel: ImageSearchViewModel?
}

extension ImageSearchCoordinator: ImageSearchViewModelDelegate {
    
    func showDetailImage(with info: SearchedImageInfo) {
        let coord = DetailImageCoordinator(navigationController: navigationController)
        coord.delegate = self
        childCoordinators[DetailImageCoordinator] = coord
        coord.start(with: info)
    }
}
