import UIKit

final class PKFooterLoadingCollectionReusableView: UICollectionReusableView {
    static let identifire = String(describing: PKFooterLoadingCollectionReusableView.self)
    
    private lazy var loader: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.color = .red
        
        return spinner
    }()
    //MARK: - initial
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Unsupport")
    }
    
    public func startAnimation() {
        loader.startAnimating()
    }
}
//MARK: - SetUp View
private extension PKFooterLoadingCollectionReusableView {
    func setUpView() {
        backgroundColor = PKColorTypeEnum.background.uiColor
        addSubview(loader)
        addConstraint()
    }
}
//MARK: - Add Constraints
private extension PKFooterLoadingCollectionReusableView {
    func addConstraint() {
        NSLayoutConstraint.activate([
            loader.widthAnchor.constraint(equalToConstant: 100),
            loader.heightAnchor.constraint(equalToConstant: 100),
            loader.centerXAnchor.constraint(equalTo: centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
