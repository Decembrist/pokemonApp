import Foundation

protocol PKSearchInteractorInputProtocol: AnyObject {
    var presenter: PKSearchInteractorOutputProtocol { get set }
}

protocol PKSearchInteractorOutputProtocol: AnyObject {
    
}

final class PKSearchInteractor: PKSearchInteractorInputProtocol {
    unowned var presenter: PKSearchInteractorOutputProtocol
    
    init(presenter: PKSearchInteractorOutputProtocol) {
        self.presenter = presenter
    }
}
