import UIKit

final class SettingsViewController: UIViewController {

    private let settingsView = SettingsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayer()
    }
}
//MARK: - SetUp Layer
private extension SettingsViewController {
    func setUpLayer() {
        title = "Settings"
        view.backgroundColor = PKColorTypeEnum.background.uiColor
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        view.addSubview(settingsView)
        addConstraint()
    }
}
//MARK: - Add Constraint
private extension SettingsViewController {
    func addConstraint() {
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            settingsView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 70),
            settingsView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -70),
        ])
    }
}
