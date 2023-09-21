//
//  BaseMainViewModel.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import Foundation
import RxSwift
import RxCocoa

/// Main screen base view model
class BaseMainViewModel: ViewModelProtocol {
    
    struct Injections {
        let serviceHolder: ServiceHolder
    }
    
    internal struct Input {
        let itemsSelected: Observable<IndexPath>
        let disposeBag: DisposeBag
    }
    
    internal struct Output {
        let collectionItems: Driver<[Products]>
        let isLoading: Driver<Bool>
    }
    
    public var openProductDetails = BehaviorSubject<ProductDataType?>(value: nil)
    
    init(injections: Injections) {}
    
    func transform(_ input: Input, outputHandler: @escaping (Output) -> Void) {}
}
