//
//  TapBarController.swift
//  Pokemons
//
//  Created by Андрей Павлов on 21.03.2023.
//

import UIKit

class TapBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().backgroundColor = .white
        
        let startController = PKListViewController()
        let settingsController = SettingsViewController()
        
        startController.navigationItem.largeTitleDisplayMode = .automatic
        settingsController.navigationItem.largeTitleDisplayMode = .automatic
        
        let navStartController = UINavigationController(rootViewController: startController)
        let navSettingsController = UINavigationController(rootViewController: settingsController)
        
        navStartController.tabBarItem = UITabBarItem(title: "All", image: UIImage(systemName: "person"), tag: 1)
        navSettingsController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        
        navStartController.navigationBar.prefersLargeTitles = true
        navSettingsController.navigationBar.prefersLargeTitles = true
        
        
        
        setViewControllers([navStartController, navSettingsController], animated: true)
    }
}
