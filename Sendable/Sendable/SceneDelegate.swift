//
//  SceneDelegate.swift
//  Sendable
//
//  Created by Iker Gonzalez on 11/18/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        // Create the main tab bar controller
        let tabBarController = createMainTabBarController()
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
    private func createMainTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        // Create Feed tab
        let feedViewController = FeedViewController()
        let feedNavController = UINavigationController(rootViewController: feedViewController)
        feedNavController.tabBarItem = UITabBarItem(
            title: "Feed", 
            image: UIImage(systemName: "house"), 
            selectedImage: UIImage(systemName: "house.fill")
        )
        feedViewController.title = "Feed"
        
        // Create Post tab
        let postViewController = PostViewController()
        let postNavController = UINavigationController(rootViewController: postViewController)
        postNavController.tabBarItem = UITabBarItem(
            title: "Post", 
            image: UIImage(systemName: "plus.circle"), 
            selectedImage: UIImage(systemName: "plus.circle.fill")
        )
        postViewController.title = "New Post"
        
        // Create Profile tab
        let profileViewController = ProfileViewController()
        let profileNavController = UINavigationController(rootViewController: profileViewController)
        profileNavController.tabBarItem = UITabBarItem(
            title: "Profile", 
            image: UIImage(systemName: "person"), 
            selectedImage: UIImage(systemName: "person.fill")
        )
        profileViewController.title = "My Posts"
        
        tabBarController.viewControllers = [
            feedNavController,
            postNavController,
            profileNavController
        ]
        
        // Customize tab bar appearance
        tabBarController.tabBar.tintColor = .systemBlue
        tabBarController.tabBar.backgroundColor = .systemBackground
        
        return tabBarController
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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

