//
//  View.swift
//  Pokemons
//
//  Created by Андрей Павлов on 12.04.2023.
//

import UIKit

public extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { self.addSubview($0) }
    }
    
    static func createAuthorisizeView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }
}
