import Foundation

protocol PKListConfiguratorProtocol {
    func configure(with viewController: PKListViewPotocolCombine)
}

final class PKListConfigurator: PKListConfiguratorProtocol {
    
    func configure(with viewController: PKListViewPotocolCombine) {
        
        let viewControllerCasted = viewController as! PKListViewController
        
        let presenter = PKListPresenter(view: viewController)
        let interactor = PKListInteractor(presenter: presenter)
        let router = PKListRouter(viewController: viewControllerCasted)
        
        viewControllerCasted.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
