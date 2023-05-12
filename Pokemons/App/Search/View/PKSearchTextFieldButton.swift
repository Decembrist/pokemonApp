import UIKit

final class PKSearchTextFieldButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpButton() {
        widthAnchor.constraint(equalToConstant: 40).isActive = true
        tintColor = .gray
        setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
    }
}
