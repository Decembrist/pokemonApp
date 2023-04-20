//
//  TypePokemonResponse.swift
//  Pokemons
//
//  Created by Андрей Павлов on 13.04.2023.
//

import Foundation

struct TypePokemonResponse: Decodable {
    
    struct TypePokemon: Decodable {
        let pokemon: NameUrlModel
    }
    let pokemon: [TypePokemon]
}
