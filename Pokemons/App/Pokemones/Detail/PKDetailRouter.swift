import Foundation

protocol PKDetailRouterProtocol {
    var view: PKDetailViewController { get set }
}

final class PKDetailRouter: PKDetailRouterProtocol {
    unowned var view: PKDetailViewController
    
    init(view: PKDetailViewController) {
        self.view = view
    }
}
