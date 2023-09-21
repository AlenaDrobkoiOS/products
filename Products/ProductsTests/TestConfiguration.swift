//
//  TestConfiguration.swift
//  ProductsTests
//
//  Created by Alena Drobko on 06.08.23.
//

import UIKit
import RxSwift
@testable import Products

class TestConfiguration {
    static func getServiceHolder() -> ServiceHolder? {
        guard let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return nil
        }
        let serviceHolder = delegate.appCoordinator?.serviceHolder
        
        let productsTestUseCase = UseCaseFactory.makeProductsTestUseCase()
        serviceHolder?.add(ProductsUseCaseType.self, for: productsTestUseCase)
        
        return serviceHolder
    }
}
