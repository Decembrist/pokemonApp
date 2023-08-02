//
//  CUstomLable.swift
//  Pokemons
//
//  Created by Андрей Павлов on 24.03.2023.
//

import UIKit

class CustomLabel: UILabel {
    var padding: UIEdgeInsets = .zero
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    override var intrinsicContentSize : CGSize {
        let sz = super.intrinsicContentSize
        return CGSize(width: sz.width + padding.left + padding.right, height: sz.height + padding.top + padding.bottom)
    }
    
//    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
//        bounds.inset(by: UIEdgeInsets)
//    }
}
