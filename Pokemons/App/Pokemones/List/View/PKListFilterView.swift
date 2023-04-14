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
    
    private lazy var filterContainer = ViewHelper.createEmptyView()
    
    private lazy var filterViewScrollContainer = ViewHelper.createEmptyView()
    
    private lazy var filterClearButton: UIButton = {
        
        var buttonConfiguration = UIButton.Configuration.gray()
        buttonConfiguration.cornerStyle = .capsule
        buttonConfiguration.title = "Clear"
        
        let button = UIButton(configuration: buttonConfiguration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(clearFilter), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var clearButtonContainer: UIView = {
        let view = ViewHelper.createEmptyView()
        
        
        
        return view
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
        addGradientClearButtonContainer()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addGradientClearButtonContainer() {
        clearButtonContainer.layoutIfNeeded()
        let colorTop =  UIColor(red: 1, green: 1, blue: 1, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = clearButtonContainer.bounds
        
        clearButtonContainer.layer.insertSublayer(gradientLayer, at:0)
    }
    
    private func setUpViews() {
        addSubview(filterContainer)
        clearButtonContainer.addSubview(filterClearButton)
        filterContainer.addSubview(filterViewScrollContainer)
        filterContainer.addSubview(clearButtonContainer)
        
        filterViewScrollContainer.addSubview(filterScrollView)
        filterScrollView.addSubview(stackScrollElementList)
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            filterContainer.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            filterContainer.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            filterContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            filterContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            clearButtonContainer.topAnchor.constraint(equalTo: filterContainer.topAnchor),
            clearButtonContainer.leftAnchor.constraint(equalTo: filterContainer.leftAnchor),
            clearButtonContainer.widthAnchor.constraint(equalToConstant: 74),
            clearButtonContainer.bottomAnchor.constraint(equalTo: filterContainer.bottomAnchor),
            
            filterClearButton.topAnchor.constraint(equalTo: clearButtonContainer.topAnchor),
            filterClearButton.leftAnchor.constraint(equalTo: clearButtonContainer.leftAnchor),
            filterClearButton.bottomAnchor.constraint(equalTo: clearButtonContainer.bottomAnchor),
            
            filterViewScrollContainer.topAnchor.constraint(equalTo: filterContainer.topAnchor),
            filterViewScrollContainer.leftAnchor.constraint(equalTo: clearButtonContainer.rightAnchor),
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
