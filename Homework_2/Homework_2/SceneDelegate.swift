//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Андрей Байдаченко on 20.07.2022.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        
        
        let feedViewController = UINavigationController(rootViewController: FeedViewController())
        
        let profileController = LogInViewController()
        let loginFactoryVC = MyLoginFactory()
        profileController.loginDelegate = loginFactoryVC.makeLoginInspector()
        let profileViewController = UINavigationController(rootViewController: profileController)
        
        let infoViewController = UINavigationController(rootViewController: InfoViewController())
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .clear
        tabBarController.tabBar.tintColor = UIColor.black
        tabBarController.tabBar.unselectedItemTintColor = .gray
        tabBarController.viewControllers = [feedViewController, profileViewController, infoViewController]
        tabBarController.viewControllers?[0].tabBarItem.title = "Главная"
        tabBarController.viewControllers?[1].tabBarItem.title = "Профиль"
        tabBarController.viewControllers?[2].tabBarItem.title = "Инфо"
        tabBarController.viewControllers?[0].tabBarItem.image = UIImage(systemName: "note.text")
        tabBarController.viewControllers?[1].tabBarItem.image = UIImage(systemName: "person")
        tabBarController.viewControllers?[2].tabBarItem.image = UIImage(systemName: "info")
    
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
    
        NetworkManager.request(for: .planets)
        //NetworkManager.request(for: .people)
        //NetworkManager.request(for: .starship)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        try? Auth.auth().signOut()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

