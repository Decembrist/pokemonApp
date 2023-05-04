import UIKit

//MARK: - ViewProtocol
protocol PKListViewProtocol: AnyObject {
    func pushToDetail(with pokemon: PokemonModel)
    func showPokemonList(_ pokemonList: [PokemonModel])
    func retrivePokemonList()
    func setIndicatorLoader(_ value: Bool)
    func scrollToTop(_ animated: Bool)
}

final class PKListView: UIView {
    
    public weak var delegate: PKListViewProtocol?
    
    private var pokemonList: [PokemonModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private var pokemonListSafe: [PokemonModel] {
        pokemonList
    }
    
    private var showIndicatorLoader = false
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = PKColorTypeEnum.background.uiColor
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            PKListViewCell.self,
            forCellWithReuseIdentifier: PKListViewCell.cellIdentifier)
        collectionView.register(
            PKFooterLoadingCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: PKFooterLoadingCollectionReusableView.identifire)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}
//MARK: - Delegate
extension PKListView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonListSafe.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        
        guard let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: PKFooterLoadingCollectionReusableView.identifire,
            for: indexPath
        ) as? PKFooterLoadingCollectionReusableView else {
            return UICollectionReusableView()
        }
        
        footer.startAnimation()
        delegate?.retrivePokemonList()
        
        return footer
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForFooterInSection section: Int
    ) -> CGSize {
        
        guard showIndicatorLoader else {
            return .zero
        }
        
        return CGSize(width: frame.size.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PKListViewCell.cellIdentifier,
            for: indexPath
        ) as? PKListViewCell else {
            fatalError()
        }
        
        cell.configure(pokemonListSafe[indexPath.row])
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon = pokemonListSafe[indexPath.row]
        
        delegate?.pushToDetail(with: pokemon)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        let width = (bounds.width / 2) - 10
        
        return CGSize(width: width, height: 100) // create enum
    }
}
//MARK: - Public Functions
extension PKListView {
    public func setPokemonList(_ pokemonList: [PokemonModel]) {
        self.pokemonList = pokemonList
    }
    
    public func setIndicatorValue(_ value: Bool) {
        self.showIndicatorLoader = value
    }
    
    public func scrollToTop(_ animated: Bool) {
        collectionView.setContentOffset(.zero, animated: animated)
    }
}
//MARK: - SetUp View
private extension PKListView {
    func setUpView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = PKColorTypeEnum.background.uiColor
        
        addSubview(collectionView)
        addConstraint()
    }
}
//MARK: - Add Constraints
private extension PKListView {
    func addConstraint() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
