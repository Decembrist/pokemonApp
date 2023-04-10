import UIKit
import Alamofire

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
    
    private var pokemonList: [PokemonModel] = []
    
    private var urlPokemonList: String {
        
        guard let nextUrl = nextPage else {
            return "https://pokeapi.co/api/v2/pokemon/"
        }
        
        return nextUrl
    }
    
    private var isLoadingMoreCharacters = false
    private var nextPage: String?
    private var needShowIndicator: Bool {
        nextPage != nil
    }
    
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

        AF.request(urlPokemonList)
            .responseDecodable(of:AllResponsePokemonModel.self, queue: .global(qos: .utility)) { [weak self] response in
            guard let strongSelf = self else {
                return
            }
            switch response.result {
            case .success(let responseModel):

                strongSelf.nextPage = responseModel.next

                for pokemon in responseModel.results {
                    strongSelf.fetchPokemonDetail(pokemon.url)
                }

                strongSelf.asyncEmitter.notify(queue: .main) {
                    strongSelf.presenter.didRetrivePokemons(strongSelf.pokemonList)
                    strongSelf.presenter.didRetriveLoadIndicator(strongSelf.needShowIndicator)
                    strongSelf.isLoadingMoreCharacters = false
                }
            case .failure(let error):
                print("fetch error:")
                print(error)
                break
            }
        }
    }
    
    private func fetchPokemonDetail(_ url: String) {

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        self.asyncEmitter.enter()
        AF.request(url)
            .responseDecodable(of:PokemonModel.self, decoder: decoder) { [weak self] response in
            defer {
                self?.asyncEmitter.leave()
            }
            switch response.result {
            case .success(let responseModel):
                self?.pokemonList.append(responseModel)
            case .failure(let error):
                print("detail error:")
                print(error)
                break
            }
        }
    }
    
    func retriveType() {
        AF.request("https://pokeapi.co/api/v2/type/")
            .responseDecodable(of: AllResponseTypePokemon.self) { [weak self] response in
                
            switch response.result {
            case .success(let responseModel):
                self?.presenter.didRetriveType(responseModel.results.compactMap{ $0.nameCapitalized })
            case .failure(let error):
                print(error)
                break
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
