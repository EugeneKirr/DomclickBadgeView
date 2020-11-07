//
//  SceneDelegate.swift
//  DomclickBadgeCountView
//
//  Created by Eugene Kireichev on 07.11.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController")
        let nvc = UINavigationController(rootViewController: vc)
        window?.rootViewController = nvc
    }

}

