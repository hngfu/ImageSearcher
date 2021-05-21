//
//  Coordinator.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/21.
//

import UIKit

class Coordinator {
    
    let navigationController: UINavigationController
    var childCoordinators = TypeKeyDictionary<Coordinator>()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
