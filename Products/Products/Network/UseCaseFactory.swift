//
//  UseCaseFactory.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import Foundation

struct UseCaseFactory {
    static func makeProductsUseCase() -> ProductsUseCaseType {
        return ProductsUseCase(baseUrl: Constants.baseURL)
    }
    
    ///here may be used some dev test api
    static func makeProductsTestUseCase() -> ProductsUseCaseType {
        return ProductsUseCase(baseUrl: Constants.baseURL)
    }
}
