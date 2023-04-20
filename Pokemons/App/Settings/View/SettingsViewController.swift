//
//  SettingsViewController.swift
//  Pokemons
//
//  Created by Андрей Павлов on 21.03.2023.
//

import UIKit

class SettingsViewController: UIViewController {

    private let settingsView = SettingsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = PKColorTypeEnum.background.uiColor
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        view.addSubview(settingsView)
        addConstraint()
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            settingsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            settingsView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 70),
            settingsView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -70),
//            settingsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

}
