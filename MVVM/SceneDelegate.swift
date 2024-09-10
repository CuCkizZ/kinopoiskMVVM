//
//  SceneDelegate.swift
//  MVVM
//
//  Created by Nikita Beglov on 25.06.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let mvc = MainViewController()
        let navBarController = UINavigationController(rootViewController: mvc)
        window?.rootViewController = navBarController
        window?.makeKeyAndVisible()
    }
}
