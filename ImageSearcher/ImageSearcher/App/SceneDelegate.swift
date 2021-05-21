//
//  SceneDelegate.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        rootCoordinator = RootCoordinator(navigationController: navigationController)
        rootCoordinator?.start()
    }
    
    //MARK: - Private
    private var rootCoordinator: RootCoordinator?
}

