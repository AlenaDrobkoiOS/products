//
//  AppCordinator.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import Foundation

import UIKit
import RxSwift

/// General App Coordinator
final class AppCoordinator: Coordinator<Void> {
    
    struct Injections {
        let window: UIWindow
    }
    
    private let window: UIWindow
    
    private var navigationController = UINavigationController()
    internal var serviceHolder = ServiceHolder()
    
    init(injections: Injections) {
        self.window = injections.window
        super.init()
    }
    
    @discardableResult // ignore return value
    override func start() -> Observable<Void> {
        setUp()
        coordinateToMain()
        return .never()
    }
    
    private func setUp() {
        setUpNC()
        setUpServices()
    }
    
    private func coordinateToMain() {
        let mainCoordinator = MainCoordinator(injections: .init(navigationController: navigationController,
                                                                serviceHolder: serviceHolder))
       coordinate(to: mainCoordinator)
    }
    
    /// Init some services, add services to service holder
    private func setUpServices() {
        let productsUseCase = UseCaseFactory.makeProductsUseCase()
        serviceHolder.add(ProductsUseCaseType.self, for: productsUseCase)
        
        let hapticFeedbackService = HapticFeedbackService()
        serviceHolder.add(HapticFeedbackServiceType.self, for: hapticFeedbackService)
        
        let alertService = AlertService(hapticFeedbackService)
        serviceHolder.add(AlertServiceType.self, for: alertService)
    }
    
    /// Set up navigation controller
    private func setUpNC() {
        navigationController.navigationBar.barTintColor = .white
        navigationController.setNavigationBarHidden(true, animated: false)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
