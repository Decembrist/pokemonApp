import Foundation

protocol PKSearchPresenterProtocol: AnyObject {
    var viewController: PKSearchViewController { get set }
    
    var interactor: PKSearchInteractorInputProtocol? { get set }
    var router: PKSearchRouterProtocol? { get set }
    
    func retrivePokemon(by name: String)
}

final class PKSearchPresenter: PKSearchPresenterProtocol {
    
    unowned var viewController: PKSearchViewController
    
    var interactor: PKSearchInteractorInputProtocol?
    var router: PKSearchRouterProtocol?
    
    init(viewController: PKSearchViewController) {
        self.viewController = viewController
    }
}

extension PKSearchPresenter {
    func retrivePokemon(by name: String) {
        print(name)
    }
}

extension PKSearchPresenter: PKSearchInteractorOutputProtocol {}
