//
//  ViewControllerExtension.swift
//  Granthi
//
//  Created by Kabindra Karki on 28/08/2021.
//

import UIKit

extension UIViewController {
    func hideNativeNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func hideTabbar(_ b: Bool) {
        self.tabBarController?.tabBar.isHidden = b
    }
    
    @objc func backToPreviousVC() {
        navigationController?.popViewController(animated: true)
    }
}
