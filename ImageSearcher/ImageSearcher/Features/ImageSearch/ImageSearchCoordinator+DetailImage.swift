//
//  ImageSearchCoordinator+DetailImage.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/23.
//

import Foundation

extension ImageSearchCoordinator: DetailImageCoordinatorDelegate {
    
    func clearDetailImage() {
        childCoordinators[DetailImageCoordinator] = nil
    }
}
