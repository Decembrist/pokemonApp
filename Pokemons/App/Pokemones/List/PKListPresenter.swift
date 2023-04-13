import Foundation

protocol PKListPresenterProtocol: AnyObject {
    
    var viewController: PKListViewPotocolCombine { get set }
    var interactor: PKListInteractorInputProtocol? { get set }
    var router: PKListRouterProtocol? { get set }
    
    // MARK: ViewListPokemon
    func showPokemonDetail(_ pokemon: PokemonModel)
    func retrivePokemons()
    
    // MARK: ViewListFilter
    func selectFilter(_ typeId: Int)
    func clearFilter()
    func retriveType()
}

final class PKListPresenter: PKListPresenterProtocol {
    
    unowned var viewController: PKListViewPotocolCombine
    var interactor: PKListInteractorInputProtocol?
    var router: PKListRouterProtocol?
    
    private var isLoadingMoreCharacters: Bool = false
    private let asyncEmitter = DispatchGroup()
    private var storePokemonList: [PokemonModel] = []

    init(view: PKListViewPotocolCombine) {
        viewController = view
    }
    
    func showPokemonDetail(_ pokemon: PokemonModel) {
        
        HapticsManager.shared.selectionVibrate()
        router?.showPokemonDetail(for: pokemon)
    }
    
    func retrivePokemons() {
        guard !isLoadingMoreCharacters else {
            return
        }
        isLoadingMoreCharacters = true
        interactor?.retrivePokemon()
    }
    
    func selectFilter(_ typeId: Int) {
        guard !isLoadingMoreCharacters else {
            return
        }
        isLoadingMoreCharacters = true
        interactor?.selectFilter(typeId)
    }
    
    func clearFilter() {
        interactor?.clearFilter()
    }
    
    func retriveType() {
        interactor?.retriveType()
    }
   
}

extension PKListPresenter: PKListInteractorOutputProtocol {
    func didRetrivePokemons(_ response: PokemonResponseModel, reinit: Bool) {
        
        viewController.setIndicatorLoader(response.nextPage != nil)
        PKPager.pokemonNextPage = response.nextPage
        
        if reinit {
            storePokemonList.removeAll()
            viewController.scrollToTop(false)
        }
        
        viewController.setIndicatorLoader(response.nextPage != nil)
        storePokemonList += response.pokemonList.sorted { $0.id < $1.id }
        viewController.showPokemonList(storePokemonList)
        isLoadingMoreCharacters = false
    }
    
    func didRetriveType(_ typeList: [NameUrlModel]) {
        viewController.showType(typeList)
    }
}
