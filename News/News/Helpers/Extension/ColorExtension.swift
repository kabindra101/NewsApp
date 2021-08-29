//
//  ColorExtension.swift
//  CodeCommerce
//
//  Created by Kabindra Karki on 3/17/20.
//  Copyright © 2020 Kabindra Karki. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}
