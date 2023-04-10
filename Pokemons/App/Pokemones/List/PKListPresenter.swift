
import Foundation

protocol PKListPresenterProtocol: AnyObject {
    
    var viewController: PKListViewPotocolCombine { get set }
    var interactor: PKListInteractorInputProtocol? { get set }
    var router: PKListRouterProtocol? { get set }
    
    // MARK: ViewListPokemon
    func showPokemonDetail(_ pokemon: PokemonModel)
    func retrivePokemons()
    
    // MARK: ViewListFilter
    func selectFilter()
    func clearFilter()
    func retriveType()
}

final class PKListPresenter: PKListPresenterProtocol {
    
    unowned var viewController: PKListViewPotocolCombine
    var interactor: PKListInteractorInputProtocol?
    var router: PKListRouterProtocol?

    init(view: PKListViewPotocolCombine) {
        viewController = view
    }
    
    func showPokemonDetail(_ pokemon: PokemonModel) {
        router?.showPokemonDetail(for: pokemon)
    }
    
    func retrivePokemons() {
        interactor?.retrivePokemon()
    }
    
    func selectFilter() {
        interactor?.selectFilter()
    }
    
    func clearFilter() {
        interactor?.clearFilter()
    }
    
    func retriveType() {
        interactor?.retriveType()
    }
   
}

extension PKListPresenter: PKListInteractorOutputProtocol {
    func didRetrivePokemons(_ pokemonList: [PokemonModel]) {
        
        let pokemonListSorted = pokemonList.sorted { $0.id < $1.id }
        
        viewController.showPokemonList(pokemonListSorted)
    }
    
    func didRetriveLoadIndicator(_ value: Bool) {
        viewController.setIndicatorLoader(value)
    }
    
    func didRetriveType(_ typeList: [String]) {
        viewController.showType(typeList)
    }
}
