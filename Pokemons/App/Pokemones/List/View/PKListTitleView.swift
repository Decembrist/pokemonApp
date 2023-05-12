import UIKit

final class PKListTitleView: UIView {
    
    private lazy var titleLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Pokemones"
        label.textColor = .black
        
        return label
    }()
    //MARK: - Initial
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}
//MARK: - SetUp View
private extension PKListTitleView {
    func setUpViews() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLable)
        addConstraint()
    }
}
//MARK: - Add constraints
private extension PKListTitleView {
    func addConstraint() {
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            titleLable.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            titleLable.rightAnchor.constraint(equalTo: rightAnchor),
            titleLable.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }
}
