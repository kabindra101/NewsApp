//
//  ReusableLabel.swift
//  News
//
//  Created by Kabindra Karki on 28/08/2021.
//

import UIKit

class ReusableLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    var insetsPadding: UIEdgeInsets = .zero
    
    init(title: String, textColor: UIColor?, numberOfLines: Int, textAlignment: NSTextAlignment, font: UIFont, padding: UIEdgeInsets = .zero, backgroundColor: UIColor? = .clear) {
        super.init(frame: .zero)
        self.text = title
        self.textColor = textColor
        self.numberOfLines = numberOfLines
        self.textAlignment = textAlignment
        self.font = font
        self.insetsPadding = padding
        self.backgroundColor = backgroundColor ?? .clear
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: insetsPadding.top, left: insetsPadding.left, bottom: insetsPadding.bottom, right: insetsPadding.right)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + insetsPadding.left + insetsPadding.right,
                      height: size.height + insetsPadding.top + insetsPadding.bottom)
    }
    
    override var bounds: CGRect {
        didSet {
            preferredMaxLayoutWidth = bounds.width - (insetsPadding.left + insetsPadding.right)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
