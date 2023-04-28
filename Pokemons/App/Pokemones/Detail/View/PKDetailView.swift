import UIKit

final class PKDetailView: UIView {
    
    private var statisticView: PKStatisticBlockView?
    
    private var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
    
    private lazy var marginTopWhiteBackground = self.screenHeight / 5
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alwaysBounceVertical = true
        view.delegate = self
        return view
    }()
    
    private lazy var scrollContainer = UIView.createAutoresizeView()
    
    private lazy var imagePokemon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private lazy var bottomBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = PKColorTypeEnum.background.uiColor
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
        configButton.baseForegroundColor = PKColorTypeEnum.background.uiColor
        configButton.image = UIImage(systemName: PKImageName.Pokemon.buttonType.rawValue)
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
        addConstraint()
        
        bottomBackground.transform = CGAffineTransform(translationX: 0, y: 100)
        bottomBackground.alpha = 0
        
        guard
            let imageString = model.pokemonImageUrlString,
            let urlImage = URL(string: imageString) else {
            return
        }
        
        imagePokemon.af.setImage(withURL: urlImage, cacheKey: imageString)
        imagePokemon.alpha = 0
        
        titleLabel.text = model.name.uppercased()
        
        let typeButton = createTypeButton(model.mainType, bgColor: model.pokemonColor)
        typeButton.transform = CGAffineTransform(translationX: 0, y: -20)
        typeButton.alpha = 0
        scrollContainer.addSubview(typeButton)

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

        scrollContainer.addSubview(statisticView)

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
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            scrollContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContainer.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            scrollContainer.rightAnchor.constraint(equalTo: scrollView.rightAnchor),

            scrollContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            scrollContainer.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
        
            bottomBackground.heightAnchor.constraint(equalToConstant: screenHeight),
            bottomBackground.leftAnchor.constraint(equalTo: scrollContainer.leftAnchor),
            bottomBackground.rightAnchor.constraint(equalTo: scrollContainer.rightAnchor),
            bottomBackground.bottomAnchor.constraint(equalTo: scrollContainer.bottomAnchor, constant: marginTopWhiteBackground),
            
            titleLabel.topAnchor.constraint(equalTo: bottomBackground.topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: scrollContainer.centerXAnchor),
            
            imagePokemon.bottomAnchor.constraint(equalTo: bottomBackground.topAnchor, constant: 10),
            imagePokemon.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    private func setUpView() {
        addSubview(scrollView)
        scrollView.addSubview(scrollContainer)
        scrollContainer.addSubviews([
            bottomBackground,
            imagePokemon,
            titleLabel
        ])
    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        print(scrollView.frame.height)
//    }
}

extension PKDetailView: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset)
//    }
}
