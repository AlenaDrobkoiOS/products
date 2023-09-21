//
//  UIWindow.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import UIKit

extension UIWindow {
    static var key: UIWindow? {
        return UIApplication
            .shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .last
    }
}
