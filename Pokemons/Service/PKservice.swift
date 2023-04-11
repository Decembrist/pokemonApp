import Foundation


final class PKService {
    
    private static var nextPage: String?
    
    private init() {}
    
    static func getPokemonList(completion: @escaping (PokemonResponseModel) -> Void) {
        PKNetworkManager.shared.requestByModel(
            PKPager.pokemonNexPage ?? "https://pokeapi.co/api/v2/pokemon",
            excpecting: AllResponsePokemonModel.self
        ) { result in
            
            switch result {
            case .success(let responseModel):
                
                let asyncEmitter = DispatchGroup()
                var pokemonList: [PokemonModel] = []
                for pokemon in responseModel.results {
                    asyncEmitter.enter()
                    fetchPokemonDetail(pokemon.url) { pokemon in
                        pokemonList.append(pokemon)
                        asyncEmitter.leave()
                    }
                }

                asyncEmitter.notify(queue: .global(qos: .utility)) {
                    PKPager.pokemonNexPage = responseModel.next
                    
                    let responsePokemonModel = PokemonResponseModel(pokemonList: pokemonList, nextPage: responseModel.next)
                    
                    completion(responsePokemonModel)
                }
                
            case .failure(let failure):
                print(failure)
                break
            }
        }
    }
    
    static func fetchPokemonDetail(_ url: String, completion: @escaping (PokemonModel) -> Void) {
        
        PKNetworkManager.shared.requestByModel(url, excpecting: PokemonModel.self) { result in
            switch result {
            case .success(let pokemonModel):
                completion(pokemonModel)
            case .failure(let failure):
                print(failure)
                break
            }
        }
    }
    
    static func getPokemonTypeList(completion: @escaping ([NameUrlModel]) -> Void) {
        PKNetworkManager.shared.requestByModel("https://pokeapi.co/api/v2/type/", excpecting: AllResponseTypePokemon.self) { result in
            switch result {
            case .success(let success):
                completion(success.results)
            case .failure(let failure):
                print(failure)
                break
            }
        }
    }
}
