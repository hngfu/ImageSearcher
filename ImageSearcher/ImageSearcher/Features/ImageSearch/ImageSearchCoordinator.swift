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
        self.viewModel = viewModel
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: false)
    }
    
    //MARK: - Private
    private var viewModel: ImageSearchViewModel?
}
