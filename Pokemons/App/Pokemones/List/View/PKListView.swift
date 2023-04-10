import UIKit

protocol PKListViewProtocol: AnyObject {
    func pushToDetail(with pokemon: PokemonModel)
    
    func showPokemonList(_ pokemonList: [PokemonModel])
    
    func retrivePokemonList()
    
    func setIndicatorLoader(_ value: Bool)
}

final class PKListView: UIView {
    
    public weak var delegate: PKListViewProtocol?
    
    private var pokemonList: [PokemonModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let cellSize = CGSize(width: 186.5, height: 100)
    
    private var showIndicatorLoader = false
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        /// register cell
        collectionView.register(PKListViewCell.self,
                                forCellWithReuseIdentifier: PKListViewCell.cellIdentifier)
        /// register footer loader
        collectionView.register(
            PKFooterLoadingCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: PKFooterLoadingCollectionReusableView.identifire)
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addSubview(collectionView)
        
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    /// func
    public func setPokemonList(_ pokemonList: [PokemonModel]) {
        self.pokemonList = pokemonList
    }
    
    public func setIndicatorValue(_ value: Bool) {
        self.showIndicatorLoader = value
    }
    
}

extension PKListView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionFooter,
                withReuseIdentifier: PKFooterLoadingCollectionReusableView.identifire,
                for: indexPath
              ) as? PKFooterLoadingCollectionReusableView else {
            fatalError("Unsupported")
        }
        
        footer.startAnimation()
        
        delegate?.retrivePokemonList()
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
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
        
        cell.configure(pokemonList[indexPath.row])
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon = pokemonList[indexPath.row]
        
        delegate?.pushToDetail(with: pokemon)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        // print(view.bounds.width / 2) 196.5
        return cellSize // create enum
    }
}
