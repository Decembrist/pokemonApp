import UIKit

class PKSearchViewController: UIViewController {
    
    public var presenter: PKSearchPresenter?
    private let configurator = PKSearchConfigurator()

    private lazy var noResultImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "no-result")
        
        return image
    }()
        
    private let searchTextField = PKSearchTextField(placeholder: "Find your pokemon")
    private let searchButton = PKSearchTextFieldButton()
    
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
//            , noResultImage
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
        NSLayoutConstraint.activate([
            searchTextField.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            searchTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            searchTextField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8)
        ])
    }
}
extension PKSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("qwe")
    }
}
//MARK: - VIPER
extension PKSearchViewController {
    @objc
    private func actionSearch() {
        guard let searchText = searchTextField.text else { return }
        presenter?.retrivePokemon(by: searchText)
    }
}
