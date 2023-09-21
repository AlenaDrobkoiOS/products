//
//  UIApplication.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import UIKit

extension UIApplication {
    
    class func getTopViewController(base: UIViewController? = UIWindow.key?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
            
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
            
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
