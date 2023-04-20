import UIKit

final class PKStatisticBlockView: UIView {
    
    private let minimumStatValue = 30

    private lazy var stackViewX: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        
        return stackView
    }()
    
    private lazy var stackName = createStackElement()
    private lazy var stackValue = createStackElement()
    private lazy var stackRange = createStackElement()
    
    init(frame: CGRect, model: PokemonModel) {
        super.init(frame: frame)
        addSubview(stackViewX)
        setUpLayer()
        setUpViews(model)
        addConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func createStackElement() -> UIStackView {
        let stackElement = UIStackView()
        stackElement.axis = .vertical
        stackElement.spacing = 2
        
        return stackElement
    }
    
    private func createProgressElement(val: Int) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let progressColor: UIColor = val <= self.minimumStatValue ? .red : .green
        
        let rangeView = UIProgressView()
        rangeView.progress = Float(val) / 100
        rangeView.translatesAutoresizingMaskIntoConstraints = false
        rangeView.progressTintColor = progressColor
        rangeView.trackTintColor = .lightGray
        container.addSubview(rangeView)
        
        NSLayoutConstraint.activate([
            container.heightAnchor.constraint(equalToConstant: 20),
            container.widthAnchor.constraint(equalToConstant: 100),
            
            rangeView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            rangeView.leftAnchor.constraint(equalTo: container.leftAnchor),
            rangeView.rightAnchor.constraint(equalTo: container.rightAnchor),
            
        ])
        
        return container
    }
    
    private func setUpLayer() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = PKColorTypeEnum.background.uiColor
        layer.cornerRadius = 50
        layer.shadowOpacity = 0.2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 10
    }
    
    private func setUpViews(_ model: PokemonModel) {

        stackRange.alignment = .center

        stackViewX.addArrangedSubview(stackName)
        stackViewX.addArrangedSubview(stackValue)
        stackViewX.addArrangedSubview(stackRange)
        
        model.stats.forEach { stat in
            let nameLabel = UILabel()
            nameLabel.textColor = .black
            nameLabel.text = stat.stat.name
            
            stackName.addArrangedSubview(nameLabel)
        }
        model.stats.forEach { stat in
            let valueLabel = UILabel()
            valueLabel.textColor = .black
            valueLabel.text = "\(stat.baseStat)"
            
            stackValue.addArrangedSubview(valueLabel)
        }
        model.stats.forEach { stat in
            let progressView = createProgressElement(val: stat.baseStat)
            
            stackRange.addArrangedSubview(progressView)
        }
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            stackViewX.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            stackViewX.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            stackViewX.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            stackViewX.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
        ])
    }

}
