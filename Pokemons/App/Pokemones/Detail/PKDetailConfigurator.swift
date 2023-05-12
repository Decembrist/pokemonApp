import Foundation

protocol PKDetailConfiguratorProtocol: AnyObject {
    func configure(with viewController: PKDetailViewController)
}

final class PKDetailConfigurator: PKDetailConfiguratorProtocol {
    
    func configure(with viewController: PKDetailViewController) {
        
        let presenter = PKDetailPresenter(view: viewController)
        let interactor = PKDetailInteractor(presenter: presenter)
        let router = PKDetailRouter(view: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
