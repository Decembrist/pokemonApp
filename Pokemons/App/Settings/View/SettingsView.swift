//
//  SettingsView.swift
//  Pokemons
//
//  Created by Андрей Павлов on 17.04.2023.
//

import UIKit

class SettingsView: UIView {

    
    private lazy var containerY: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        
        return stack
    }()
    
    
    private func createSection(name: String) -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        
        let label = UILabel()
        label.text = name
        label.textColor = .black
        
        let switcher = UISwitch()
//        switcher.
        
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(switcher)
        
        return stack
    }
    
    private let sections = ["Hide Names", "Hide Type"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpLayer()
        
        
        addConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpLayer() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(containerY)
        
        for name in sections {
            containerY.addArrangedSubview(createSection(name: name))
        }
        
    }

    private func addConstraint() {
        NSLayoutConstraint.activate([
            containerY.topAnchor.constraint(equalTo: topAnchor),
            containerY.leftAnchor.constraint(equalTo: leftAnchor),
            containerY.rightAnchor.constraint(equalTo: rightAnchor),
            containerY.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
