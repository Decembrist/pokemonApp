import UIKit

protocol PKListFilterViewProtocol: AnyObject {
    func selectFilter(_ typeId: Int)
    func clearFilter()
    func retriveType()
    func showType(_ typeList: [NameUrlModel])
}

final class PKListFilterView: UIView {
    
    public weak var delegate: PKListFilterViewProtocol?
    
    private var typeList: [NameUrlModel] = [] {
        didSet {
            for typeItem in typeList {
                
                let urlSubstring = typeItem.url.split(whereSeparator: { $0 == "/"})
                
                guard let last = urlSubstring.last, let typeId = Int(last) else { return }

                let button = self.createScrollElem(title: typeItem.nameCapitalized, tag: typeId)
                self.stackScrollElementList.addArrangedSubview(button)
            }
        }
    }
    
    private lazy var filterContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var filterViewScrollContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var filterClearButton: UIButton = {
        
        var buttonConfiguration = UIButton.Configuration.gray()
        buttonConfiguration.cornerStyle = .capsule
        buttonConfiguration.title = "Clear"
        
        let button = UIButton(configuration: buttonConfiguration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(clearFilter), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var filterScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsHorizontalScrollIndicator = true
        
        return scroll
    }()
    
    private lazy var stackScrollElementList: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.spacing = 5
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = PKColorType.background
        
        setUpViews()
        addConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpViews() {
        addSubview(filterContainer)
        filterContainer.addSubview(filterClearButton)
        filterContainer.addSubview(filterViewScrollContainer)
        filterViewScrollContainer.addSubview(filterScrollView)
        filterScrollView.addSubview(stackScrollElementList)
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            filterContainer.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            filterContainer.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            filterContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            filterContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            filterClearButton.topAnchor.constraint(equalTo: filterContainer.topAnchor),
            filterClearButton.leftAnchor.constraint(equalTo: filterContainer.leftAnchor),
            filterClearButton.bottomAnchor.constraint(equalTo: filterContainer.bottomAnchor),
            filterViewScrollContainer.topAnchor.constraint(equalTo: filterContainer.topAnchor),
            filterViewScrollContainer.leftAnchor.constraint(equalTo: filterClearButton.rightAnchor, constant: 10),
            filterViewScrollContainer.rightAnchor.constraint(equalTo: filterContainer.rightAnchor),
            filterViewScrollContainer.bottomAnchor.constraint(equalTo: filterContainer.bottomAnchor),
            filterScrollView.topAnchor.constraint(equalTo: filterViewScrollContainer.topAnchor),
            filterScrollView.leftAnchor.constraint(equalTo: filterViewScrollContainer.leftAnchor),
            filterScrollView.rightAnchor.constraint(equalTo: filterViewScrollContainer.rightAnchor),
            filterScrollView.bottomAnchor.constraint(equalTo: filterViewScrollContainer.bottomAnchor),
            stackScrollElementList.topAnchor.constraint(equalTo: filterScrollView.topAnchor),
            stackScrollElementList.leftAnchor.constraint(equalTo: filterScrollView.leftAnchor),
            stackScrollElementList.rightAnchor.constraint(equalTo: filterScrollView.rightAnchor),
            stackScrollElementList.bottomAnchor.constraint(equalTo: filterScrollView.bottomAnchor),
        ])
    }
    
    private func createScrollElem(title: String, tag: Int) -> UIButton {
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.titlePadding = 10
        buttonConfiguration.cornerStyle = .capsule
        buttonConfiguration.title = title
        buttonConfiguration.baseForegroundColor = .white
        buttonConfiguration.baseBackgroundColor = UIColor(named: title)
        
        let button = UIButton(configuration: buttonConfiguration)
        button.addTarget(self, action: #selector(selectFilter(_:)), for: .touchUpInside)
        button.tag = tag
        
        return button
    }
    
    @objc
    private func selectFilter(_ sender: UIButton) {
        delegate?.selectFilter(sender.tag)
    }

    @objc
    private func clearFilter() {
        delegate?.clearFilter()
    }
    
    func setTypeList(_ typeList: [NameUrlModel]) {
        self.typeList = typeList
    }
}
