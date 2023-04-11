import UIKit

final class PKFooterLoadingCollectionReusableView: UICollectionReusableView {
    static let identifire = "PKFooterLoadingCollectionReusableView"
    
    private lazy var loader: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupport")
    }
    
    private func setUpView() {
        addSubview(loader)
        NSLayoutConstraint.activate([
            loader.widthAnchor.constraint(equalToConstant: 100),
            loader.heightAnchor.constraint(equalToConstant: 100),
            loader.centerXAnchor.constraint(equalTo: centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    public func startAnimation() {
        loader.startAnimating()
    }
}
