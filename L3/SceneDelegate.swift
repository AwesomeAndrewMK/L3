//
//  SceneDelegate.swift
//  L3
//
//  Created by Andrii Kuznietsov on 04.12.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createRootViewContoller()
        window?.makeKeyAndVisible()
    }
    
    func createRootViewContoller() -> UIViewController {
        let rootVC = UINavigationController(rootViewController: MainViewController())
        rootVC.isNavigationBarHidden = true
        
        return rootVC
    }
}

