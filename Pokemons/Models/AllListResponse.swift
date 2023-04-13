//
//  AllListResponse.swift
//  Pokemons
//
//  Created by Андрей Павлов on 13.04.2023.
//

import Foundation

struct AllListResponse: Decodable {
    let count: Int
    let next: String?
    let previus: String?
    let results: [NameUrlModel]
}
