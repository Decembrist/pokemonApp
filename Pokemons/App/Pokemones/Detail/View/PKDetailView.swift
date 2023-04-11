import UIKit

class PKDetailView: UIView {
    
    private var statisticView: PKStatisticBlockView?
    
    private lazy var imagePokemon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private lazy var bottomBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = PKColorType.background
        view.layer.cornerRadius = 40
        view.layer.shadowOpacity = 0.1
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 5
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.font = .systemFont(ofSize: 22, weight: .medium)
        title.textColor = .black
        
        return title
    }()
    
    private func createTypeButton(_ title: String, bgColor: UIColor) -> UIButton {
        var configButton = UIButton.Configuration.filled()
        configButton.title = title
        configButton.cornerStyle = .capsule
        configButton.baseBackgroundColor = bgColor
        configButton.baseForegroundColor = PKColorType.background
        configButton.image = UIImage(systemName: PKImageName.Pokemon.buttonType.name)
        configButton.imagePadding = 10
        configButton.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30)
        
        let button = UIButton(configuration: configButton)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }

    init(frame: CGRect, model: PokemonModel) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = model.pokemonColor
        
        setUpView()
        
        imagePokemon.af.setImage(withURL: model.pokeonImageUrl, cacheKey: model.pokemonImageUrlString)
        imagePokemon.alpha = 0
        
        titleLabel.text = model.name.uppercased()
        
        let typeButton = createTypeButton(model.mainType, bgColor: model.pokemonColor)
        typeButton.transform = CGAffineTransform(translationX: 0, y: -20)
        typeButton.alpha = 0
        addSubview(typeButton)

        UIView.animate(withDuration: 0.3) {
            
            self.imagePokemon.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
            self.imagePokemon.alpha = 1
            
            typeButton.transform = .identity
            typeButton.alpha = 1
            
            self.bottomBackground.transform = .identity
            self.bottomBackground.alpha = 1
        }
        
        NSLayoutConstraint.activate([
            typeButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            typeButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        statisticView = PKStatisticBlockView(frame: .zero, model: model)
        guard let statisticView = statisticView else { return }
        
        addSubview(statisticView)
        
        statisticView.transform = CGAffineTransform(translationX: 0, y: 60)
        statisticView.alpha = 0
        
        
        UIView.animate(withDuration: 0.3, delay: 0.3) {
            statisticView.transform = .identity
            statisticView.alpha = 1
        }

        
        NSLayoutConstraint.activate([
            statisticView.topAnchor.constraint(equalTo: typeButton.bottomAnchor, constant: 20),
            statisticView.widthAnchor.constraint(equalToConstant: 340),
            statisticView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpView() {
        addSubview(bottomBackground)
        addSubview(imagePokemon)
        addSubview(titleLabel)
        
        bottomBackground.transform = CGAffineTransform(translationX: 0, y: 100)
        bottomBackground.alpha = 0
        
        NSLayoutConstraint.activate([
            bottomBackground.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 1.4),
            bottomBackground.leftAnchor.constraint(equalTo: leftAnchor),
            bottomBackground.rightAnchor.constraint(equalTo: rightAnchor),
            bottomBackground.bottomAnchor.constraint(equalTo: bottomAnchor),

            imagePokemon.bottomAnchor.constraint(equalTo: bottomBackground.topAnchor, constant: 10),
            imagePokemon.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: bottomBackground.topAnchor, constant: 40),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
        ])
        
    }
}
