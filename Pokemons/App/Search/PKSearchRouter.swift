import Foundation

protocol PKSearchRouterProtocol: AnyObject {
    var viewController: PKSearchViewController { get set }
}

final class PKSearchRouter: PKSearchRouterProtocol {
    
    unowned var viewController: PKSearchViewController
    
    init(viewController: PKSearchViewController) {
        self.viewController = viewController
    }
}
