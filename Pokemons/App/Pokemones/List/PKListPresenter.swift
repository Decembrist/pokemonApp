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
    // MARK: LoaderView
    func startLoader()
    func stopLoader()
}

final class PKListPresenter: PKListPresenterProtocol {
    
    unowned var viewController: PKListViewPotocolCombine
    var interactor: PKListInteractorInputProtocol?
    var router: PKListRouterProtocol?
    
    private var isLoadingMoreCharacters: Bool = false
    private let asyncEmitter = DispatchGroup()
    private var storePokemonList: [PokemonModel] = []
    private var enableClearFilter = false

    init(view: PKListViewPotocolCombine) {
        viewController = view
    }
}
/// ListView
extension PKListPresenter {
    func showPokemonDetail(_ pokemon: PokemonModel) {
        HapticsManager.shared.selectionVibrate()
        router?.showPokemonDetail(for: pokemon)
    }
    
    func retrivePokemons() {
        if isLoadingMoreCharacters {
            return
        }
        isLoadingMoreCharacters = true
        interactor?.retrivePokemon()
    }
    
    func retriveType() {
        interactor?.retriveType()
    }
}
/// FilterView
extension PKListPresenter {
    func selectFilter(_ typeId: Int) {
        if isLoadingMoreCharacters {
            return
        }
        enableClearFilter = true
        startLoader()
        isLoadingMoreCharacters = true
        interactor?.selectFilter(typeId)
    }
    
    func clearFilter() {
        guard enableClearFilter else { return }
        enableClearFilter = false
        startLoader()
        interactor?.clearFilter()
    }
}
/// LoaderView
extension PKListPresenter {
    func startLoader() {
        viewController.start()
    }
    func stopLoader() {
        viewController.stop()
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
        stopLoader()
    }
    
    func didRetriveType(_ typeList: [NameUrlModel]) {
        viewController.showType(typeList)
    }
}
