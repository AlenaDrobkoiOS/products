//
//  DetailsViewModel.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import Foundation
import RxSwift
import RxCocoa

/// Details screen view model
final class DetailsViewModel: BaseDetailsViewModel {
    
    private let hapticFeedbackService: HapticFeedbackServiceType
    
    private let bag = DisposeBag()
    internal var tableItems = BehaviorRelay<[DetailsCellModel]>(value: [])
    
    override init(injections: Injections) {
        hapticFeedbackService = injections.serviceHolder.get(by: HapticFeedbackServiceType.self)
        
        super.init(injections: injections)
        
        setUpInfo(injections.productInfo)
    }
    
    private func setUpInfo(_ productInfo: ProductDataType) {
        var info: [DetailsCellModel] = []
        info.append(.image(productInfo.imageURL))
        info.append(.text(.title(productInfo.title)))
        info.append(.text(.price(price: productInfo.price, strokePrice: productInfo.strikePrice)))
        info.append(.text(.content(productInfo.description)))
        tableItems.accept(info)
    }
    
    override func transform(_ input: Input, outputHandler: @escaping (Output) -> Void) {
        input.disposeBag.insert([
            input.backTapped
                .do(onNext: { [weak self] _ in
                    self?.hapticFeedbackService.generate.onNext(.swipe)
                })
                .bind(to: dismiss)
        ])
        
        let output = Output(tableItems: tableItems.asDriver())
        outputHandler(output)
    }
}
