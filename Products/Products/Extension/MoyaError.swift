//
//  MoyaError.swift
//  Products
//
//  Created by Alena Drobko on 06.08.23.
//

import Moya
import Alamofire

typealias NetworkError = MoyaError

extension MoyaError {
    public var failureReason: String? {
        switch self {
        case .underlying:
            return (self.errorUserInfo[NSUnderlyingErrorKey] as? AFError)?.underlyingError?.localizedDescription
        default:
            return self.errorDescription
        }
    }
}
