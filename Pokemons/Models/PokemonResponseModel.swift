
import Foundation


struct PokemonResponseModel: Decodable {
    let pokemonList: [PokemonModel]
    let nextPage: String?
}
