import UIKit

class SettingsView: UIView {

    private lazy var containerY: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        
        return stack
    }()
    
    private func createSection(name: String) -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        
        let label = UILabel()
        label.text = name
        label.textColor = .black
        
        let switcher = UISwitch()
        
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(switcher)
        
        return stack
    }
    
    private let sections = ["Hide Names", "Hide Type"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayer()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}
private extension SettingsView {
    func setUpLayer() {
        addSubview(containerY)
        for name in sections {
            containerY.addArrangedSubview(createSection(name: name))
        }
        addConstraint()
    }
}
//MARK: - Add constraint
private extension SettingsView {
    func addConstraint() {
        NSLayoutConstraint.activate([
            containerY.topAnchor.constraint(equalTo: topAnchor),
            containerY.leftAnchor.constraint(equalTo: leftAnchor),
            containerY.rightAnchor.constraint(equalTo: rightAnchor),
            containerY.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
