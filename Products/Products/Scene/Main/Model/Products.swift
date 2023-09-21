//
//  Products.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import Foundation
import RxDataSources

struct Products: Equatable {
    var title: String // Header title
    var products: [ProductDataType] // List of products in category
    
    init(title: String, products: [ProductDataType]) {
        self.title = title
        self.products = products
    }
    
    init(with model: CategoryDataType) {
        self.title = model.title
        self.products = model.products
    }
    
    init(with model: ProductsResponce) {
        self.title = Constants.defaultTitle
        self.products = model.products
    }
}

extension Products: AnimatableSectionModelType {
    typealias Item = ProductDataType
    typealias Identity = String
    
    var identity: String {
        return title
    }
    
    var items: [Item] {
          set {
              products = newValue
          }
          get {
              return products
          }
      }

    init(original: Products, items: [ProductDataType]) {
        self = original
        self.items = items
    }
}
