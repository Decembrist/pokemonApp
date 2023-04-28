
import UIKit

class PKSearchTextField: UITextField {
    
    private let height: CGFloat = 50
    private let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 40)

    init(placeholder: String) {
        super.init(frame: .zero)
        setUpTextField(placeholder: placeholder)
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    private func setUpTextField(placeholder: String) {
        textColor = .black
        
        
        layer.cornerRadius = 10
        backgroundColor = PKColorTypeEnum.background.uiColor
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 7
        layer.shadowOffset = CGSize(width: 0, height: 5)
        
        font = .boldSystemFont(ofSize: 18)
        
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        
        heightAnchor.constraint(equalToConstant: self.height).isActive = true
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
}
