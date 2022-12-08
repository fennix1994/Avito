//
//  SceneDelegate.swift
//  Avito
//
//  Created by Кирилл Сурков on 27.10.2022.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var router: RouterProtocol!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let appWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
        let assembly = Builder(networkService: NetworkService())
        router = Router(
            window: appWindow,
            assembly: assembly
        )
        
        window = appWindow 
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        router.start()
    }
}


