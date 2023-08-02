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
        var urlComponents = URLComponents()
        urlComponents.host = "pokeapi.co"
        urlComponents.scheme = "https"
        urlComponents.path = "/api/v2"
        
        switch self {
        case .pokemonList:
            urlComponents.path += "/pokemon"
        case .pokemonDetail(let id):
            urlComponents.path += "/pokemon/\(id)/"
        case .pokemonDetailByName(let name):
            urlComponents.path += "/pokemon/\(name)/"
        case .typeList:
            urlComponents.path += "/type"
        case .typeDetail(let id):
            urlComponents.path += "/type/\(id)/"
        }
        
        return urlComponents.url!.absoluteString
    }
}
