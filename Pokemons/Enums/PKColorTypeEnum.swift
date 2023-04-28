//
//  PKColorTypeEnum.swift
//  Pokemons
//
//  Created by Андрей Павлов on 20.04.2023.
//

import UIKit.UIColor

enum PKColorTypeEnum {
    
    case background
    
    var uiColor: UIColor {
        switch self {
        case .background:
            return .white
        }
    }
}
