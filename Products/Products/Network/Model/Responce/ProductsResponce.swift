//
//  ProductsResponce.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import Foundation
import RxDataSources

/// Products responce data model - contains info that comes with products responce
struct ProductsResponce: BaseResponseProtocol {
    var code: String?
    var message: String?
    
    var products: [ProductDataType]
}

/// ProductsCategory responce data model - contains info that comes with productsCategory responce
struct ProductsCategoryResponce: BaseResponseProtocol {
    var code: String?
    var message: String?
    
    var categories: [CategoryDataType]
}

struct CategoryDataType: Codable {
    var title: String // Category title
    var products: [ProductDataType] // List of products in category
}

struct ProductDataType: Codable {
    
    let id: String?
    let title: String
    let imageURL: String?
    let price: Double
    let strikePrice: Double?
    let description: String
    
    /*
     json
    {
        "id": "some id",
        "title": "Product title",
        "imageURL": "Url to image",
        "price": 1.59,
        "strikePrice": 2.0,
        "description": "Product description"
    }
    */
}

extension ProductDataType: IdentifiableType {
    typealias Identity = String
    
    var identity: String {
        return title
    }
}

extension ProductDataType: Equatable {
    static func == (lhs: ProductDataType, rhs: ProductDataType) -> Bool {
        return lhs.identity == rhs.identity
    }
}
