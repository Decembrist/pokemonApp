import Foundation

protocol PKListRouterProtocol: AnyObject {
    
    var viewController: PKListViewController { get set }
    
    func showPokemonDetail(for pokemon: PokemonModel)
}

final class PKListRouter: PKListRouterProtocol {
    
    unowned var viewController: PKListViewController
    
    init(viewController: PKListViewController) {
        self.viewController = viewController
    }
    
    func showPokemonDetail(for pokemon: PokemonModel) {
        let vc = PKDetailViewController(model: pokemon)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
