import Foundation

protocol PKDetailPresenterProtocol: AnyObject {
    var view: PKDetailViewController { get set }
    
    var interactor: PKDetailInteractorInputProtocol? { get set }
    var router: PKDetailRouterProtocol? { get set }
}

final class PKDetailPresenter: PKDetailPresenterProtocol {
    
    unowned var view: PKDetailViewController
    
    var interactor: PKDetailInteractorInputProtocol?
    var router: PKDetailRouterProtocol?
    
    init(view: PKDetailViewController) {
        self.view = view
    }
}

extension PKDetailPresenter: PKDetailInteractorOutputProtocol {}
