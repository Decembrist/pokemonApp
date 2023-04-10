import UIKit

typealias PKListViewPotocolCombine = PKListViewProtocol & PKListFilterViewProtocol

final class PKListViewController: UIViewController {
    
    ///viper
    var presenter: PKListPresenter!
    let configurator = PKListConfigurator()
    
    /// views
    private let pokemonListView = PKListView()
    private let titleView = PKListTitleView()
    private let filterView = PKListFilterView()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configurator.configure(with: self)
        
        setUpDelegate()
        addSubviews()
        addConstraints()
        setUpNavBar()
        
        /// fetching data
        retrivePokemonList()
        retriveType()
        
    }
    
    private func setUpDelegate() {
        pokemonListView.delegate = self
        filterView.delegate = self
    }
    
    private func setUpNavBar() {
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func addSubviews() {
        [filterView, titleView, pokemonListView].forEach {
            view.addSubview($0)
        }
    }
    
    private func addConstraints() {
        
        NSLayoutConstraint.activate([
            filterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            filterView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            
            titleView.topAnchor.constraint(equalTo: filterView.bottomAnchor),
            titleView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            titleView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            pokemonListView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            pokemonListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            pokemonListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            pokemonListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
       
}

// MARK: VIPER
extension PKListViewController: PKListViewProtocol {
    
    func retrivePokemonList() {
        presenter.retrivePokemons()
    }
    
    func pushToDetail(with pokemon: PokemonModel) {
        presenter.showPokemonDetail(pokemon)
    }
    
    func showPokemonList(_ pokemonList: [PokemonModel]) {
        pokemonListView.setPokemonList(pokemonList)
    }
    
    func setIndicatorLoader(_ value: Bool) {
        pokemonListView.setIndicatorValue(value)
    }
}

extension PKListViewController: PKListFilterViewProtocol {
    
    func selectFilter() {
        presenter.selectFilter()
    }
    
    func clearFilter() {
        presenter.clearFilter()
    }
    
    func retriveType() {
        presenter.retriveType()
    }
    
    func showType(_ typeList: [String]) {
        filterView.setTypeList(typeList)
    }
    
}
