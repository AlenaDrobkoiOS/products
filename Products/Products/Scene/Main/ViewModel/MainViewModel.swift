//
//  MainViewModel.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import Foundation
import RxSwift
import RxCocoa

/// Main screen view model
final class MainViewModel: BaseMainViewModel {
    enum ProductType {
        case list
        case category
    }
    
    private let bag = DisposeBag()
    
    internal let productsUseCase: ProductsUseCaseType
    private let alertService: AlertServiceType
    private let hapticFeedbackService: HapticFeedbackServiceType
    
    internal var collectionItems: BehaviorRelay<[Products]> = BehaviorRelay<[Products]>(value: [])
    internal let isLoading = BehaviorRelay<Bool>(value: true)
    
    override init(injections: Injections) {
        productsUseCase = injections.serviceHolder.get(by: ProductsUseCaseType.self)
        alertService = injections.serviceHolder.get(by: AlertServiceType.self)
        hapticFeedbackService = injections.serviceHolder.get(by: HapticFeedbackServiceType.self)
        
        super.init(injections: injections)
        
        fetchProducts(by: .category)
    }
    
    internal func fetchProducts(by type: ProductType) {
        isLoading.accept(true)
        
        switch type {
        case .list:
            productsUseCase.getProductList()
                .subscribe(onSuccess: { [weak self] responce in
                    guard let self else { return }
                    
                    self.collectionItems.accept([Products.init(with: responce)])
                    self.isLoading.accept(false)
                }, onFailure: { [weak self] error in
                    self?.alertService.show.onNext(.networkError(error, retryHandler: { self?.fetchProducts(by: type) }))
                })
                .disposed(by: bag)
        case .category:
            productsUseCase.getProductListWithCategory()
                .subscribe(onSuccess: { [weak self] responce in
                    guard let self else { return }
                    
                    self.collectionItems.accept(responce.categories.map { Products.init(with: $0) })
                    self.hapticFeedbackService.generate.onNext(.success)
                    self.isLoading.accept(false)
                }, onFailure: { [weak self] error in
                    self?.alertService.show.onNext(.networkError(error, retryHandler: { self?.fetchProducts(by: type) }))
                })
                .disposed(by: bag)
        }
    }
    
    override func transform(_ input: Input, outputHandler: @escaping (Output) -> Void) {
        input.disposeBag.insert([
            setUpItemsSelected(with: input.itemsSelected)
        ])
        
        let output = Output(
            collectionItems: collectionItems.asDriver(),
            isLoading: isLoading.asDriver()
        )
        outputHandler(output)
    }
    
    internal func setUpItemsSelected(with signal: Observable<IndexPath>) -> Disposable {
        return signal
            .map({ [weak self] indexPath -> ProductDataType? in
                guard let array = self?.collectionItems.value,
                      array.count > indexPath.section,
                      array[indexPath.section].products.count > indexPath.row else { return nil }
                return array[indexPath.section].products[indexPath.row]
            })
            .bind { [weak self] info in
                guard let self, let info else { return }
                self.hapticFeedbackService.generate.onNext(.selected)
                self.openProductDetails.onNext(info)
            }
    }
}
