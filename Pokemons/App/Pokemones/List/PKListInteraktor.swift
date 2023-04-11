import UIKit


protocol PKListInteractorInputProtocol: AnyObject {

    var presenter: PKListInteractorOutputProtocol { get set }
    
    func retriveResultIndicaotr()
    
    func retrivePokemon()
    
    func selectFilter()
    func clearFilter()
    func retriveType()
}

protocol PKListInteractorOutputProtocol: AnyObject {
    func didRetrivePokemons(_ pokemonList: [PokemonModel])
    func didRetriveLoadIndicator(_ value: Bool)
    func didRetriveType(_ typeList: [String])
}

final class PKListInteractor: PKListInteractorInputProtocol {
    
    unowned var presenter: PKListInteractorOutputProtocol
    
    private var isLoadingMoreCharacters: Bool = false

    private var needShowIndicator: Bool = false
    
    private let asyncEmitter = DispatchGroup()
    
    init(presenter: PKListInteractorOutputProtocol) {
        self.presenter = presenter
    }

    func retriveResultIndicaotr() {
        presenter.didRetriveLoadIndicator(needShowIndicator)
    }

    func retrivePokemon() {
        
        guard !isLoadingMoreCharacters else {
            return
        }

        isLoadingMoreCharacters = true

        PKService.getPokemonList { [weak self] responseModel in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.presenter.didRetrivePokemons(responseModel.pokemonList)
            
            if let _ = responseModel.nextPage {
                strongSelf.needShowIndicator = true
                strongSelf.presenter.didRetriveLoadIndicator(true)
                
            } else {
                strongSelf.needShowIndicator = false
                strongSelf.presenter.didRetriveLoadIndicator(false)
            }
            
            strongSelf.isLoadingMoreCharacters = false
        }
        

    }
    
    func retriveType() {
        PKService.getPokemonTypeList { [weak self] typeList in
            DispatchQueue.main.async {
                self?.presenter.didRetriveType(typeList.compactMap{ $0.nameCapitalized })
            }   
        }
    }
    
    func selectFilter() {
        print("action filter select")
    }
    
    func clearFilter() {
        print("action filter clear")
    }
    
}
