//
//  BaseDetailsViewModel.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import Foundation
import RxSwift
import RxCocoa

/// Details screen base view model
class BaseDetailsViewModel: ViewModelProtocol {
    struct Injections {
        let serviceHolder: ServiceHolder
        let productInfo: ProductDataType
    }
    
    internal struct Input {
        var backTapped: Observable<Void>
        var disposeBag: DisposeBag
    }
    
    internal struct Output {
        var tableItems: Driver<[DetailsCellModel]>
    }
    
    var dismiss = PublishSubject<Void>()
    
    init(injections: Injections) {}
    
    func transform(_ input: Input, outputHandler: @escaping (Output) -> Void) {}
}
