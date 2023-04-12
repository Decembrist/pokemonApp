//
//  AllResponseTypePokemon.swift
//  Pokemons
//
//  Created by Андрей Павлов on 28.03.2023.
//

import Foundation

struct AllTypePokemonResponse: Decodable {
    let results: [NameUrlModel]
}
