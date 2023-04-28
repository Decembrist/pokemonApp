import Foundation

protocol PKSearchConfiguratorProtocol: AnyObject {
    func configure(with viewController: PKSearchViewController)
}

final class PKSearchConfigurator: PKSearchConfiguratorProtocol {
    
    func configure(with viewController: PKSearchViewController) {
        
        let presenter = PKSearchPresenter(viewController: viewController)
        let interactor = PKSearchInteractor(presenter: presenter)
        let router = PKSearchRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
    
}
