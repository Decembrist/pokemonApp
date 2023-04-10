//
//  SmallResultModel.swift
//  Pokemons
//
//  Created by Андрей Павлов on 21.03.2023.
//

import Foundation

struct NameUrlModel: Codable {
    let name: String
    let url: String
    
    var nameCapitalized: String {
        return name.capitalized
    }
}
