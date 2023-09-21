//
//  MainCoordinator.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import UIKit
import RxSwift

/// Main screen coordinator
final class MainCoordinator: Coordinator<Void> {
    struct Injections {
        let navigationController: UINavigationController
        let serviceHolder: ServiceHolder
    }
    
    private let navigationController: UINavigationController
    private let serviceHolder: ServiceHolder
    
    init(injections: Injections) {
        self.navigationController = injections.navigationController
        self.serviceHolder = injections.serviceHolder
    }
    
    @discardableResult // ignore return value
    override func start() -> Observable<Void> {
        let viewModel: BaseMainViewModel = MainViewModel(injections: .init(serviceHolder: serviceHolder))
        let controller = MainViewController(viewModel: viewModel)
        
        navigationController.pushViewController(controller, animated: false)
    
        viewModel.openProductDetails
            .compactMap({ $0 })
            .flatMap { info in
                self.openProductDetails(with: info)
            }
            .bind { result in
                switch result {
                case .dismiss:
                    print("Product dismissed")
                }
            }
            .disposed(by: disposeBag)
        
        return .never()
    }
    
    private func openProductDetails(with productInfo: ProductDataType) -> Observable<DetailsCoordinatorResult>  {
        let coordinator = DetailsCoordinator(injections: .init(navigationController: navigationController,
                                                               serviceHolder: serviceHolder,
                                                               productInfo: productInfo))
        return coordinate(to: coordinator)
    }
}
