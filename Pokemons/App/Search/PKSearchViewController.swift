//
//  PKSearchViewController.swift
//  Pokemons
//
//  Created by Андрей Павлов on 19.04.2023.
//

import UIKit

class PKSearchViewController: UIViewController {

    private lazy var imageResult: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "no-result")
        
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = PKColorTypeEnum.background.uiColor
        view.addSubview(imageResult)
        title = "Search"
        imageResult.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        imageResult.center = view.center
//        addConstraint()

    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            imageResult.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            imageResult.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    


}
