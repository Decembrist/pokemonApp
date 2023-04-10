//
//  AllResponsePokemon.swift
//  Pokemons
//
//  Created by Андрей Павлов on 21.03.2023.
//

import Foundation

struct AllResponsePokemonModel: Codable {
    let count: Int
    let next: String?
    let previus: String?
    let results: [NameUrlModel]
}
