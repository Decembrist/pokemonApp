import UIKit
import Alamofire
import AlamofireImage

final class PKListViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "PokemonListViewCell"
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let lable = UILabel()
        lable.textColor = .white
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = .systemFont(ofSize: 18, weight: .bold)
        
        return lable
    }()
    
    private lazy var backGroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.alignment = .leading
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setUpLayer()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.af.cancelImageRequest()
        nameLabel.text = nil
        imageView.image = nil
        
        for subview in stackView.arrangedSubviews {
            subview.removeFromSuperview()
        }
    }
    
    public func configure(_ model: PokemonModel) {
        nameLabel.text = model.name
        
        if
            let imageString = model.pokemonImageUrlString,
            let urlImage = URL(string: imageString) {

            imageView.af.setImage(withURL: urlImage, cacheKey: imageString)
        }

        
        backGroundView.backgroundColor = model.pokemonColor
        model.types.forEach {
            stackView.addArrangedSubview(createLableType(title: $0.type.nameCapitalized))
        }
    }
    
    private func addSubviews() {
        contentView.addSubviews([
            backGroundView,
            nameLabel,
            stackView,
            imageView
        ])
    }
    
    private func setUpLayer() {
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            backGroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backGroundView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            backGroundView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
            backGroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 20),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
        ])
    }
    
    private func createLableType(title: String) -> UILabel {
        let label = CustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.backgroundColor = UIColor(named: "CardTipBG")
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }
    
}
