import UIKit

class TapBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().backgroundColor = PKColorType.background
        
        let startController = PKListViewController()
        let settingsController = SettingsViewController()
        
        startController.navigationItem.largeTitleDisplayMode = .automatic
        settingsController.navigationItem.largeTitleDisplayMode = .automatic
        
        let navStartController = UINavigationController(rootViewController: startController)
        let navSettingsController = UINavigationController(rootViewController: settingsController)
        
        navStartController.tabBarItem = UITabBarItem(title: "All", image: UIImage(systemName: PKImageName.Pokemon.mainIcon.name), tag: 1)
        navSettingsController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: PKImageName.Settings.mainIcon.name), tag: 2)
        
        navStartController.navigationBar.prefersLargeTitles = true
        navSettingsController.navigationBar.prefersLargeTitles = true
        
        setViewControllers([navStartController, navSettingsController], animated: true)
    }
}
