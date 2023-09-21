//
//  DetailsCoordinator.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import UIKit
import RxSwift

/// Details screen coordinator result: dismiss or openURL
enum DetailsCoordinatorResult {
    case dismiss
}

/// Details screen coordinator
final class DetailsCoordinator: Coordinator<DetailsCoordinatorResult> {
    struct Injections {
        let navigationController: UINavigationController
        let serviceHolder: ServiceHolder
        let productInfo: ProductDataType
    }

    private let navigationController: UINavigationController
    private let serviceHolder: ServiceHolder
    private let productInfo: ProductDataType
    
    init(injections: Injections) {
        self.navigationController = injections.navigationController
        self.serviceHolder = injections.serviceHolder
        self.productInfo = injections.productInfo
    }
    
    override func start() -> Observable<CoordinationResult> {
        let injections = DetailsViewModel.Injections(serviceHolder: serviceHolder, productInfo: productInfo)
        let viewModel: BaseDetailsViewModel = DetailsViewModel(injections: injections)
        let controller = DetailsViewController(viewModel: viewModel)
        
        navigationController.pushViewController(controller, animated: true)
        
        return setupRouting(viewModel: controller.viewModel)
    }
    
    private func setupRouting(viewModel: BaseDetailsViewModel) -> Observable<CoordinationResult> {
        let dismissEvent = viewModel.dismiss
            .map { _ in return CoordinationResult.dismiss }
        
        return dismissEvent
    }
}
