import UIKit

protocol PKListInteractorInputProtocol: AnyObject {

    var presenter: PKListInteractorOutputProtocol { get set }
    /// PKListView
    func retrivePokemon()
    /// PKFilterView
    func selectFilter(_ typeId: Int)
    func clearFilter()
    func retriveType()
}

protocol PKListInteractorOutputProtocol: AnyObject {
    ///PKListView
    func didRetrivePokemons(_ response: PokemonResponseModel, reinit: Bool)
    /// PKFilterView
    func didRetriveType(_ typeList: [NameUrlModel])
}

final class PKListInteractor: PKListInteractorInputProtocol {
    
    unowned var presenter: PKListInteractorOutputProtocol
    
    init(presenter: PKListInteractorOutputProtocol) {
        self.presenter = presenter
    }

    func retrivePokemon() {
        PKService.getPokemonList { [weak self] responseModel in
            self?.presenter.didRetrivePokemons(responseModel, reinit: false)
        }
    }
    
    func retriveType() {
        PKService.getPokemonTypeList { [weak self] typeList in
            DispatchQueue.main.async {
                self?.presenter.didRetriveType(typeList)
            }   
        }
    }
    
    func selectFilter(_ typeId: Int) {
        PKService.getAllPokemonListByTypeId(typeId) { [weak self] pokemonList in
            let model = PokemonResponseModel(pokemonList: pokemonList, nextPage: nil)
            self?.presenter.didRetrivePokemons(model, reinit: true)
        }
    }
    
    func clearFilter() {
        PKService.getPokemonList { [weak self] responseModel in
            self?.presenter.didRetrivePokemons(responseModel, reinit: true)
        }
    }
}
