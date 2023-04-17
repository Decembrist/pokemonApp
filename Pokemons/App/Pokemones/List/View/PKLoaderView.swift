//
//  PKLoaderView.swift
//  Pokemons
//
//  Created by Андрей Павлов on 14.04.2023.
//

import UIKit

protocol PKLoaderViewProtocol {
    func start()
    func stop()
    func toggleShowTabBar(hide: Bool)
}

final class PKLoaderView: UIView {
    
    private lazy var loader: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.color = .red
        
        return spinner
    }()
    
    private lazy var blurBackground: UIVisualEffectView = {
        let blur = UIVisualEffectView()
        blur.translatesAutoresizingMaskIntoConstraints = false
        
        return blur
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayer()
        addSubviews([blurBackground, loader])
        let blurEffect = UIBlurEffect(style: .light)
        blurBackground.effect = blurEffect
        addConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpLayer() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = PKColorType.background.withAlphaComponent(0.1)
        isHidden = true
        alpha = 0
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            loader.heightAnchor.constraint(equalToConstant: 100),
            loader.widthAnchor.constraint(equalToConstant: 100),
            loader.centerXAnchor.constraint(equalTo: centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            blurBackground.topAnchor.constraint(equalTo: topAnchor),
            blurBackground.leftAnchor.constraint(equalTo: leftAnchor),
            blurBackground.rightAnchor.constraint(equalTo: rightAnchor),
            blurBackground.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    public func start() {
        loader.startAnimating()
        isHidden = false
        alpha = 1
    }
    
    public func stop() {
        loader.stopAnimating()
        isHidden = true
        
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0
        }
    }
}
