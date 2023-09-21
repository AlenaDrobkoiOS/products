//
//  ProductsUseCase.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import RxSwift

/// ProductsUseCase service protocol
protocol ProductsUseCaseType: Service {
    func getProductList() -> Single<ProductsResponce>
    func getProductListWithCategory() -> Single<ProductsCategoryResponce>
}

/// ProductsUseCase - trigger products requests
final class ProductsUseCase: NetworkProvider<ProductsEndpoints>, ProductsUseCaseType {
    func getProductList() -> Single<ProductsResponce> {
        let model = BaseRequestDataModel(baseUrl: baseUrl,
                                         authorizationToken: authProvider?.token(),
                                         pathEnding: Constants.listProductFilename)
        return request(endpoint: .listOfProducts(requestData: model))
    }
    
    func getProductListWithCategory() -> Single<ProductsCategoryResponce> {
        let model = BaseRequestDataModel(baseUrl: baseUrl,
                                         authorizationToken: authProvider?.token(),
                                         pathEnding: Constants.listProductCategoryFilename)
        return request(endpoint: .listOfProducts(requestData: model))
    }
}
