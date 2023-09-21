//
//  Constants.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import Foundation

/// Helps with constant value
struct Constants {
    static var baseURL: URL {
        guard let url = URL(string: "https://www.shopreme.com/") else {
            fatalError("Failed attempt create URL instance \("https://www.shopreme.com/")")
        }
        return url
    }
    
    static let listProductCategoryFilename = "products_categories.json"
    static let listProductFilename = "products_simple.json"
    
    static let defaultTitle = "Obst und Gemüse"
}
