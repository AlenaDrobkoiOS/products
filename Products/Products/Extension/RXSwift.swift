//
//  RXSwift.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import RxSwift

public extension PrimitiveSequence where Trait == SingleTrait {
    /// A check is made to see if the request was successful.
    /// If the server returns an error, then the sequence emits a server error
    func checkServerError() -> Single<Element> where Element: BaseResponseProtocol {
        asObservable()
            .flatMapFirst { responseModel -> Observable<Element> in
                guard let error = responseModel.message else {
                    return .just(responseModel)
                }
                let resultError = CustomServerError.serverError(error: error)
                return .error(resultError)
            }
            .asSingle()
    }
}
