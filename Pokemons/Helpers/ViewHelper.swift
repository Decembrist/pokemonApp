//
//  ViewHelper.swift
//  Pokemons
//
//  Created by Андрей Павлов on 14.04.2023.
//

import UIKit

struct ViewHelper {
    static func createEmptyView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }
}
