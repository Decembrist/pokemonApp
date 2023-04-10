import UIKit

protocol PKListFilterViewProtocol: AnyObject {
    func selectFilter()
    func clearFilter()
    func retriveType()
    func showType(_ typeList: [String])
}

final class PKListFilterView: UIView {
    
    public weak var delegate: PKListFilterViewProtocol?
    
    private var typeList: [String] = [] {
        didSet {
            for (index, name) in typeList.enumerated() {
                let button = self.createScrollElem(title: name, tag: index)
                self.stackScrollElementList.addArrangedSubview(button)
            }
        }
    }
    
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
        
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    /// func
    
    private func setUpView() {
        addSubview(filterClearButton)
        addSubview(filterViewScrollContainer)
        filterViewScrollContainer.addSubview(filterScrollView)
        filterScrollView.addSubview(stackScrollElementList)
        
        NSLayoutConstraint.activate([
            filterClearButton.topAnchor.constraint(equalTo: topAnchor),
            filterClearButton.leftAnchor.constraint(equalTo: leftAnchor),
            filterClearButton.bottomAnchor.constraint(equalTo: bottomAnchor),

            filterViewScrollContainer.topAnchor.constraint(equalTo: topAnchor),
            filterViewScrollContainer.leftAnchor.constraint(equalTo: filterClearButton.rightAnchor, constant: 10),
            filterViewScrollContainer.rightAnchor.constraint(equalTo: rightAnchor),
            filterViewScrollContainer.bottomAnchor.constraint(equalTo: bottomAnchor),

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
        delegate?.selectFilter()
    }

    @objc
    private func clearFilter() {
        delegate?.clearFilter()
    }
    
    func setTypeList(_ typeList: [String]) {
        self.typeList = typeList
    }
}
