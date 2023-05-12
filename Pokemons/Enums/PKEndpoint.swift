//
//  PKEndpoint.swift
//  Pokemons
//
//  Created by Андрей Павлов on 07.04.2023.
//

import Foundation

enum PKEndpoint {
    case pokemonList
    case pokemonDetail(Int)
    case pokemonDetailByName(String)
    case typeList
    case typeDetail(Int)
    
    var endpoint: String {
        switch self {
        case .pokemonList:
            return "https://pokeapi.co/api/v2/pokemon"
        case .pokemonDetail(let id):
            return "https://pokeapi.co/api/v2/pokemon/\(id)/"
        case .pokemonDetailByName(let name):
            return "https://pokeapi.co/api/v2/pokemon/\(name)/"
        case .typeList:
            return "https://pokeapi.co/api/v2/type/"
        case .typeDetail(let id):
            return "https://pokeapi.co/api/v2/type/\(id)/"
        }
    }
}
