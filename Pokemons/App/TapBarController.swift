import UIKit

class TapBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().backgroundColor = PKColorTypeEnum.background.uiColor
        
        let pokemonController = PKListViewController()
        let searchController = PKSearchViewController()
        let settingsController = SettingsViewController()
        
        pokemonController.navigationItem.largeTitleDisplayMode = .automatic
        searchController.navigationItem.largeTitleDisplayMode = .automatic
        settingsController.navigationItem.largeTitleDisplayMode = .automatic
        
        let navPokemonController = UINavigationController(rootViewController: pokemonController)
        let navSearchController = UINavigationController(rootViewController: searchController)
        let navSettingsController = UINavigationController(rootViewController: settingsController)
        
        navPokemonController.tabBarItem = UITabBarItem(title: "All", image: UIImage(systemName: PKImageName.Pokemon.mainIcon.rawValue), tag: 1)
        navSearchController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: PKImageName.Search.mainIcon.rawValue), tag: 2)
        navSettingsController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: PKImageName.Settings.mainIcon.rawValue), tag: 3)
        
        navSearchController.navigationBar.prefersLargeTitles = true
        navSettingsController.navigationBar.prefersLargeTitles = true
        
        setViewControllers([navPokemonController, navSearchController, navSettingsController], animated: true)
    }
}
