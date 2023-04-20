//
//  PokemonList.swift
//  Pokemons
//
//  Created by Андрей Павлов on 21.03.2023.
//

import UIKit

struct PokemonModel: Decodable {

    struct AbilitiesModel: Decodable {
        let ability: NameUrlModel
        let isHidden: Bool
    }
    
    struct OfficialAtrworkModel: Decodable {
        let frontDefault: String?
    }
    
    struct OtherModel: Decodable {
        let officialArtwork: OfficialAtrworkModel
        
        enum CodingKeys: String, CodingKey {
            case officialArtwork = "official-artwork"
        }
    }
    
    struct SpritesModel: Decodable {
        let other: OtherModel
    }
    
    struct TypesModel: Decodable {
        let slot: Int
        let type: NameUrlModel
    }
    
    struct StatsModel: Decodable {
        let baseStat: Int
        let stat: NameUrlModel
    }
    
    let id: Int
    let name: String
    let weight: Int
    let height: Int
    let sprites: SpritesModel
    let abilities: [AbilitiesModel]
    let types: [TypesModel]
    let stats: [StatsModel]

    var pokemonImageUrlString: String? {
        sprites.other.officialArtwork.frontDefault
    }
    
    var pokemonColor: UIColor {
        UIColor(named: mainType)!
    }
    
    var mainType: String {
        (types.first?.type.nameCapitalized)!
    }
}
