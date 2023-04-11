import UIKit

final class PKStatisticBlockView: UIView {

    init(frame: CGRect, model: PokemonModel) {
        super.init(frame: frame)
        
        setUpLayer()
        
        setUpViews(model)
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
        
        let progressColor: UIColor = val <= 30 ? .systemRed : .systemGreen
        
        let rangeView = UIProgressView()
        rangeView.progress = Float(val) / 100
        rangeView.translatesAutoresizingMaskIntoConstraints = false
        rangeView.progressTintColor = progressColor
        rangeView.trackTintColor = .systemGray3
        container.addSubview(rangeView)
        
        NSLayoutConstraint.activate([
            container.heightAnchor.constraint(equalToConstant: 20.3333),
            container.widthAnchor.constraint(equalToConstant: 100),
            
            rangeView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            rangeView.leftAnchor.constraint(equalTo: container.leftAnchor),
            rangeView.rightAnchor.constraint(equalTo: container.rightAnchor),
            
        ])
        
        return container
    }
    
    private func setUpLayer() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius = 50
        layer.shadowOpacity = 0.2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 10
    }
    
    private func setUpViews(_ model: PokemonModel) {
        let stackViewX = UIStackView()
        stackViewX.translatesAutoresizingMaskIntoConstraints = false
        stackViewX.alignment = .leading
        stackViewX.distribution = .fillProportionally
        stackViewX.spacing = 0
        addSubview(stackViewX)
        
        let stackName = createStackElement()
        let stackValue = createStackElement()
        let stackRange = createStackElement()
        stackRange.alignment = .center

        stackViewX.addArrangedSubview(stackName)
        stackViewX.addArrangedSubview(stackValue)
        stackViewX.addArrangedSubview(stackRange)
        
        let stats = model.stats
        
        stats.forEach { stat in
            let nameLabel = UILabel()
            nameLabel.textColor = .black
            nameLabel.text = stat.stat.name
            
            stackName.addArrangedSubview(nameLabel)
        }
        
        stats.forEach { stat in
            let valueLabel = UILabel()
            valueLabel.text = "\(stat.baseStat)"
            
            stackValue.addArrangedSubview(valueLabel)
        }
        
        stats.forEach { stat in
            let progressView = createProgressElement(val: stat.baseStat)
            
            stackRange.addArrangedSubview(progressView)
        }
        
        NSLayoutConstraint.activate([
            stackViewX.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            stackViewX.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            stackViewX.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            stackViewX.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
        ])
    }

}
