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
        view.backgroundColor = PKColorType.background
        /// viper configurate
        configurator.configure(with: self)
        /// setup view
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
        view.addSubviews([
            titleView,
            pokemonListView, filterView
        ])
    }
    
    private func addConstraints() {
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            titleView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            pokemonListView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            pokemonListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            pokemonListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            pokemonListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            filterView.topAnchor.constraint(equalTo: pokemonListView.bottomAnchor, constant: -40),
            filterView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            filterView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
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
    
    func scrollToTop(_ animated: Bool) {
        pokemonListView.scrollToTop(animated)
    }
}

extension PKListViewController: PKListFilterViewProtocol {
    
    func selectFilter(_ typeId: Int) {
        presenter.selectFilter(typeId)
    }
    
    func clearFilter() {
        presenter.clearFilter()
    }
    
    func retriveType() {
        presenter.retriveType()
    }
    
    func showType(_ typeList: [NameUrlModel]) {
        filterView.setTypeList(typeList)
    }
    
}
