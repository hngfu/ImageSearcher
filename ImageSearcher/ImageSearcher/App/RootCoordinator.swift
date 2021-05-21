//
//  RootCoordinator.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/21.
//

import UIKit

final class RootCoordinator: Coordinator {

    func start() {
        let coord = ImageSearchCoordinator(navigationController: navigationController)
        childCoordinators[ImageSearchCoordinator] = coord
        coord.start()
    }
}
