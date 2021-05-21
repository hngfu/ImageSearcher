//
//  Storyboarded.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/21.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: "\(self)", bundle: .main)
        let viewController = storyboard.instantiateInitialViewController()
        return viewController as! Self
    }
}
