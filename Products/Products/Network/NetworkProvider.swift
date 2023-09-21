//
//  NetworkProvider.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import Moya
import RxSwift

/// Network Provider - use MoyaProvider and trigger request
class NetworkProvider<EndpointType: TargetType> {
    let provider = MoyaProvider<EndpointType>()
    
    let baseUrl: URL
    let authProvider: AuthorizationTokenProvider?
    
    init(baseUrl: URL, authProvider: AuthorizationTokenProvider? = nil) {
        self.baseUrl = baseUrl
        self.authProvider = authProvider
    }
    
    
    internal func request<T>(endpoint: EndpointType) -> Single<T> where T: BaseResponseProtocol {
        return provider.rx.request(endpoint)
            .map(T.self)
            .checkServerError()
    }
}
