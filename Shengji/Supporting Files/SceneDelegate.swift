//
//  SceneDelegate.swift
//  Shengji
//
//  Created by Kevin Peng on 2020-08-02.
//

import UIKit

@available(iOS 13, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let networkService = NetworkService.shared

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let sceneWindow = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: sceneWindow)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
    }

}

