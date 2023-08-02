import Foundation

struct PKService {
    
    static func getPokemonList(completion: @escaping (PokemonResponseModel) -> Void) {
        
        self.getAllResponse(
            PKPager.pokemonNextPage ?? PKEndpoint.pokemonList.endpoint
        ) { responseModel in
                        
            let asyncEmitter = DispatchGroup()
            var pokemonList: [PokemonModel] = []

            for pokemon in responseModel.results {
                asyncEmitter.enter()
                fetchPokemonDetail(pokemon.url) { pokemon in
                    pokemonList.append(pokemon)
                    asyncEmitter.leave()
                } fail: {
                    asyncEmitter.leave()
                }
            }

            asyncEmitter.notify(queue: .main) {
                let responsePokemonModel = PokemonResponseModel(pokemonList: pokemonList, nextPage: responseModel.next)

                completion(responsePokemonModel)
            }
        }
    }
    
    static func getAllPokemonListByTypeId(_ typeId: Int, completion: @escaping ([PokemonModel]) -> Void) {
        PKNetworkManager.shared.requestByModel(
            PKEndpoint.typeDetail(typeId).endpoint,
            excpecting: TypePokemonResponse.self
        ) { result in
            
            let asyncEmitter = DispatchGroup()
            var pokemonList: [PokemonModel] = []
            
            switch result {
            case .success(let pokemonModel):
                pokemonModel.pokemon.forEach { pokemon in
                    asyncEmitter.enter()
                    fetchPokemonDetail(pokemon.pokemon.url) { pokemon in
                        pokemonList.append(pokemon)
                        asyncEmitter.leave()
                    } fail: {
                        asyncEmitter.leave()
                    }
                }
                asyncEmitter.notify(queue: .main) {
                    completion(pokemonList)
                }
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    static func fetchPokemonDetail(
        _ url: String,
        completion: @escaping (PokemonModel) -> Void,
        fail: @escaping () -> Void
    ) {
        PKNetworkManager.shared.requestByModel(url, excpecting: PokemonModel.self) { result in
            switch result {
            case .success(let pokemonModel):
                completion(pokemonModel)
            case .failure(let failure):
                print(url)
                print(failure)
                fail()
            }
        }
    }
    
    static func getPokemonTypeList(completion: @escaping ([NameUrlModel]) -> Void) {
        self.getAllResponse(PKEndpoint.typeList.endpoint) { result in
            completion(result.results)
        }
    }
    
    private static func getAllResponse(_ url: String, completion: @escaping (AllListResponse) -> Void) {
        PKNetworkManager.shared.requestByModel(
            url,
            excpecting: AllListResponse.self
        ) { result in
            
            switch result {
            case .success(let success):
                completion(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
