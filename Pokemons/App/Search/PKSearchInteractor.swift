import Foundation

protocol PKSearchInteractorInputProtocol: AnyObject {
    var presenter: PKSearchInteractorOutputProtocol { get set }
    
    func retrivePokemon(by name: String)
}

protocol PKSearchInteractorOutputProtocol: AnyObject {
    func didRetrivePokemon(_ response: SearchPokemonresponce?)
}

final class PKSearchInteractor: PKSearchInteractorInputProtocol {
    unowned var presenter: PKSearchInteractorOutputProtocol
    
    init(presenter: PKSearchInteractorOutputProtocol) {
        self.presenter = presenter
    }
}

extension PKSearchInteractor {
    public func retrivePokemon(by name: String) {
        let requestPokemonUrlString: PKEndpoint = .pokemonDetailByName(name)
        PKService.fetchPokemonDetail(requestPokemonUrlString.endpoint) { [weak self] model in
            guard let imageUrlString = model.pokemonImageUrlString else {
                return
            }
            PKNetworkManager.shared.requestImage(imageUrlString) { data in
                DispatchQueue.main.async {
                    self?.presenter.didRetrivePokemon(.init(name: model.name, imageData: data))
                }
            }
        } fail: { [weak self] in
            DispatchQueue.main.async {
                self?.presenter.didRetrivePokemon(nil)
            }
        }
    }
}
