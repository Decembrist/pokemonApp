import UIKit

final class PKDetailViewController: UIViewController {

    private let pokemon: PokemonModel
    
    private let deteilView: PKDetailView
    
    var presenter: PKDetailPresenter?
    let configurator = PKDetailConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)

        setUpView()
        setUpBackTitle()
    }
    
    init(model: PokemonModel) {
        self.pokemon = model
        deteilView = PKDetailView(frame: .zero, model: model)
        
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        view.addSubview(deteilView)
        NSLayoutConstraint.activate([
            deteilView.topAnchor.constraint(equalTo: view.topAnchor),
            deteilView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            deteilView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            deteilView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setUpBackTitle() {
        navigationController?.navigationBar.topItem?.backButtonTitle = pokemon.name.capitalized
    }
    
}
