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
    
    init(model: PokemonModel) {
        super.init(frame: .zero)
        setUpViews(model)
    }
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}
//MARK: - SetUp views
private extension PKStatisticBlockView {
    func setUpViews(_ model: PokemonModel) {
        addSubview(stackViewX)
        let stackName = createStackElement()
        let stackValue = createStackElement()
        let stackRange = createStackElement()
        
        setUpLayer()
        
        stackRange.alignment = .center

        stackViewX.addArrangedSubview(stackName)
        stackViewX.addArrangedSubview(stackValue)
        stackViewX.addArrangedSubview(stackRange)
        
        addConstraint()
        
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
    func createStackElement() -> UIStackView {
        let stackElement = UIStackView()
        stackElement.axis = .vertical
        stackElement.spacing = 2
        
        return stackElement
    }
    func createProgressElement(val: Int) -> UIView {
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
}
//MARK: - SetUp Layer
private extension PKStatisticBlockView {
    func setUpLayer() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = PKColorTypeEnum.background.uiColor
        layer.cornerRadius = 50
        layer.shadowOpacity = 0.2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 10
    }
}
//MARK: - Add constraints
private extension PKStatisticBlockView {
    func addConstraint() {
        NSLayoutConstraint.activate([
            stackViewX.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            stackViewX.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            stackViewX.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            stackViewX.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
        ])
    }
}
