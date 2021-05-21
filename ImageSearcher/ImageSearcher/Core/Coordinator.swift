//
//  Coordinator.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/21.
//

import UIKit

protocol Coordinator {
    var childCoordinators: TypeKeyDictionary<Coordinator> { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
