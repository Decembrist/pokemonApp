import UIKit

typealias PKListViewPotocolCombine = PKListViewProtocol & PKListFilterViewProtocol & PKLoaderViewProtocol

final class PKListViewController: UIViewController {
    /// viper
    var presenter: PKListPresenter!
    let configurator = PKListConfigurator()
    /// views
    private let pokemonListView = PKListView()
    private let titleView = PKListTitleView()
    private let filterView = PKListFilterView()
    private let loaderView = PKLoaderView()
    
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
        /// viper configurate
        configurator.configure(with: self)
        /// setup view
        setUpView()
        /// fetching data
        retrivePokemonList()
        retriveType()
    }
    
    
}
//MARK: - SetUp View
private extension PKListViewController {
    func setUpView() {
        view.backgroundColor = PKColorTypeEnum.background.uiColor
        setUpDelegate()
        addSubviews()
        addConstraints()
    }
}
//MARK: - Functions
private extension PKListViewController {
    func setUpDelegate() {
        pokemonListView.delegate = self
        filterView.delegate = self
    }
    
    func addSubviews() {
        view.addSubviews([
            titleView,
            pokemonListView,
            filterView,
            loaderView
        ])
    }
}
//MARK: - Add Constraints
private extension PKListViewController {
    func addConstraints() {
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            titleView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            pokemonListView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            pokemonListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            pokemonListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            pokemonListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            filterView.topAnchor.constraint(equalTo: pokemonListView.bottomAnchor),
            filterView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            filterView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            loaderView.topAnchor.constraint(equalTo: view.topAnchor),
            loaderView.leftAnchor.constraint(equalTo: view.leftAnchor),
            loaderView.rightAnchor.constraint(equalTo: view.rightAnchor),
            loaderView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
//MARK: - ListView
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
//MARK: - FilterView
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
//MARK: - LoaderView
extension PKListViewController: PKLoaderViewProtocol {
    func start() {
        loaderView.start()
    }
    
    func stop() {
        loaderView.stop()
    }
    
    func toggleShowTabBar(hide: Bool) {
        tabBarController?.tabBar.isHidden = hide
    }
}
