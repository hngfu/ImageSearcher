//
//  RootCoordinator.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/21.
//

import UIKit

final class RootCoordinator: Coordinator {
    
    var childCoordinators = TypeKeyDictionary<Coordinator>()
    var navigationController: UINavigationController
    
    func start() {

    }
    
    //MARK: - Init & Private
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
