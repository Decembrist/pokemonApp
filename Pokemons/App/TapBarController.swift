import UIKit

class TapBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().backgroundColor = PKColorType.background
        
        let pokemonController = PKListViewController()
        let settingsController = SettingsViewController()
        
        pokemonController.navigationItem.largeTitleDisplayMode = .automatic
        settingsController.navigationItem.largeTitleDisplayMode = .automatic
        
        let navPokemonController = UINavigationController(rootViewController: pokemonController)
        let navSettingsController = UINavigationController(rootViewController: settingsController)
        
        navPokemonController.tabBarItem = UITabBarItem(title: "All", image: UIImage(systemName: PKImageName.Pokemon.mainIcon.name), tag: 1)
        navSettingsController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: PKImageName.Settings.mainIcon.name), tag: 2)
        
        navSettingsController.navigationBar.prefersLargeTitles = true
        
        setViewControllers([navPokemonController, navSettingsController], animated: true)
    }
}
