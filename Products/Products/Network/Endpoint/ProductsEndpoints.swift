//
//  ProductsEndpoints.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import Moya

/// Products requests enpoints
enum ProductsEndpoints: TargetType {
    case listOfProducts(requestData: RequestModelTypeProtocol)

    private var extractedRequestData: RequestModelTypeProtocol {
        switch self {
        case .listOfProducts(let requestData):
            return requestData
        }
    }
}

extension ProductsEndpoints{
    var baseURL: URL {
        extractedRequestData.baseUrl
    }

    var path: String {
        switch self {
        case .listOfProducts:
            return "jobinterview/data/\(extractedRequestData.pathEnding ?? "")"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .listOfProducts:
            return .get
        }
    }
    
    var task: Task {
        guard var parameters = extractedRequestData.parameters else {
            return .requestPlain
        }
        
        if extractedRequestData.authorizationToken != nil {
            parameters["apiKey"] = extractedRequestData.authorizationToken
        }
        
        switch self {
        case .listOfProducts:
            return .requestParameters(parameters: parameters,
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
