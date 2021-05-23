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
    
    func start(with: SearchedImageInfo) {
    }
}

