import UIKit

final class PKDetailViewController: UIViewController {

    private let deteilView: PKDetailView
    
    public var presenter: PKDetailPresenter?
    private let configurator = PKDetailConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        setUpView()
    }
    
    init(model: PokemonModel) {
        deteilView = PKDetailView(model: model)
        
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - SetUp View
extension PKDetailViewController {
    func setUpView() {
        view.addSubview(deteilView)
        NSLayoutConstraint.activate([
            deteilView.topAnchor.constraint(equalTo: view.topAnchor),
            deteilView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            deteilView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            deteilView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
