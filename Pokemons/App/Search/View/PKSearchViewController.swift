import UIKit

class PKSearchViewController: UIViewController {
    
    public var presenter: PKSearchPresenter?
    private let configurator = PKSearchConfigurator()
        
    private let searchTextField = PKSearchTextField(placeholder: "Find your pokemon")
    private let searchButton = PKSearchTextFieldButton()
    private let resultSearchView = PKSearchResultView()
    private let loaderView = PKLoaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
//MARK: - SetUp Views
private extension PKSearchViewController {
    func setUpViews() {
        configurator.configure(with: self)
        setUpTitle()
        setUpSearchField()
        addActions()
        view.backgroundColor = PKColorTypeEnum.background.uiColor
        view.addSubviews([
            searchTextField
            , resultSearchView
            , loaderView
        ])
        addConstraint()
    }
}
//MARK: - Settings
private extension PKSearchViewController {
    func setUpTitle() {
        title = "Search"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    func addActions() {
        searchButton.addTarget(self, action: #selector(actionSearch), for: .touchUpInside)
    }
    func setUpSearchField() {
        searchTextField.rightView = searchButton
        searchTextField.rightViewMode = .always
        searchTextField.delegate = self
    }
}
//MARK: - Constraints
private extension PKSearchViewController {
    func addConstraint() {
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        resultSearchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTextField.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            searchTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            searchTextField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            
            resultSearchView.heightAnchor.constraint(equalToConstant: 200),
            resultSearchView.bottomAnchor.constraint(equalTo: searchTextField.topAnchor),
            resultSearchView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            loaderView.topAnchor.constraint(equalTo: view.topAnchor),
            loaderView.leftAnchor.constraint(equalTo: view.leftAnchor),
            loaderView.rightAnchor.constraint(equalTo: view.rightAnchor),
            loaderView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
extension PKSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        presenter?.retrivePokemon(by: textField.text)
        return true
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
//        print()
    }
}
extension PKSearchViewController: PKLoaderViewProtocol {
    func start() {
        self.loaderView.start()
    }
    
    func stop() {
        self.loaderView.stop()
    }
    
    func toggleShowTabBar(hide: Bool) {
        self.tabBarController?.tabBar.isHidden = hide
    }
}
//MARK: - VIPER
extension PKSearchViewController {
    @objc
    private func actionSearch() {
        presenter?.retrivePokemon(by: searchTextField.text)
    }
    
    func showResult(_ response: SearchPokemonresponce?) {
        resultSearchView.setContent(response)
    }
    
    func clearTextField() {
        searchTextField.text = ""
    }
}
