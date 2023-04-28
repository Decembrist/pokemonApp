import UIKit

protocol PKDetailInteractorInputProtocol: AnyObject {
    var presenter: PKDetailInteractorOutputProtocol { get set }
}

protocol PKDetailInteractorOutputProtocol: AnyObject {
    
}


final class PKDetailInteractor: PKDetailInteractorInputProtocol {
    unowned var presenter: PKDetailInteractorOutputProtocol
    
    init(presenter: PKDetailInteractorOutputProtocol) {
        self.presenter = presenter
    }
}
