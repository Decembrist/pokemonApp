import Foundation

protocol PKSearchPresenterProtocol: AnyObject {
    var viewController: PKSearchViewController { get set }
    
    var interactor: PKSearchInteractorInputProtocol? { get set }
    var router: PKSearchRouterProtocol? { get set }
    
    func retrivePokemon(by name: String?)
}
final class PKSearchPresenter: PKSearchPresenterProtocol {
    
    private let countMinLengthChars = 3
    
    unowned var viewController: PKSearchViewController
    
    var interactor: PKSearchInteractorInputProtocol?
    var router: PKSearchRouterProtocol?
    
    init(viewController: PKSearchViewController) {
        self.viewController = viewController
    }
}
extension PKSearchPresenter {
    func retrivePokemon(by name: String?) {
        HapticsManager.shared.selectionVibrate()
        guard let searchText = name, searchText.count > countMinLengthChars else { return }
        viewController.start()
        viewController.toggleShowTabBar(hide: true)
        interactor?.retrivePokemon(by: searchText.lowercased())
    }
}
extension PKSearchPresenter: PKSearchInteractorOutputProtocol {
    func didRetrivePokemon(_ response: SearchPokemonresponce?) {
        if let _ = response?.name {
            viewController.clearTextField()
        }
        viewController.showResult(response)
        viewController.toggleShowTabBar(hide: false)
        viewController.stop()
    }
}
