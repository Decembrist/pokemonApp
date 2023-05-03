import UIKit

class PKSearchResultView: UIView {

    private let defaultText = "Pokemon not find :("
    
    private let defaultImage = UIImage(named: "no-result")
    
    private lazy var resultImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = nil
        
        return image
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = nil
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        addSubviews([resultImage, textLabel])
        NSLayoutConstraint.activate([
            resultImage.topAnchor.constraint(equalTo: topAnchor),
            resultImage.widthAnchor.constraint(equalTo: widthAnchor),
            resultImage.heightAnchor.constraint(equalToConstant: 150),
            
            textLabel.topAnchor.constraint(equalTo: resultImage.bottomAnchor),
            textLabel.leftAnchor.constraint(equalTo: leftAnchor),
            textLabel.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }
    
    public func setContent(_ model: SearchPokemonresponce?) {
        DispatchQueue.main.async {
            self.textLabel.text = model?.name ?? self.defaultText
            guard let image = model?.imageData else {
                self.resultImage.image = self.defaultImage
                return
            }
            self.resultImage.image = UIImage(data: image)
        }
    }
    
    public func clearTextField() {
        textLabel.text = ""
    }
}
