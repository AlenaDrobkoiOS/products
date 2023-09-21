//
//  AlertService.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import RxSwift

/// Alerts types: warning or error
enum AlertType {
    case warning(_ message: String)
    case error(_ error: Error)
    case networkError(_ error: Error, retryHandler: (() -> Void)? = nil)
    
    struct AlertInfo {
        let title: String
        let message: String
        let handler: (() -> Void)?
        
        init(_ title: String, _ message: String, _ handler: (() -> Void)? = nil) {
            self.title = title
            self.message = message
            self.handler = handler
        }
    }
    
    var info: AlertInfo {
        switch self {
        case .warning(let message):
            return .init(Localizationable.Global.warning.localized, message)
        case .error(let error):
            return .init(Localizationable.Global.error.localized, error.localizedDescription, nil)
        case .networkError(let error, retryHandler: let handler):
            if let error = error as? NetworkError {
                return .init(Localizationable.Global.error.localized,
                             error.failureReason ?? error.localizedDescription,
                             handler)
            } else {
                return .init(Localizationable.Global.error.localized, error.localizedDescription, handler)
            }
        }
    }
}

/// Alert Service protocol
protocol AlertServiceType: Service {
    var show: PublishSubject<AlertType> { get }
}

/// Service that helps with showing alert
final class AlertService: AlertServiceType {
    
    var show: PublishSubject<AlertType> = PublishSubject()
    
    private let hapticFeedbackService: HapticFeedbackServiceType?
    
    private let bag = DisposeBag()
    
    init(_ hapticFeedbackService: HapticFeedbackServiceType? = nil) {
        self.hapticFeedbackService = hapticFeedbackService
        
        show.asObservable()
            .bind { [weak self] alert in
                self?.showAlert(info: alert.info,
                                completion: { self?.getFeedback(with: alert) })
            }
            .disposed(by: bag)
    }
    
    fileprivate func showAlert(info: AlertType.AlertInfo, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: info.title, message: info.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: (info.handler == nil ? Localizationable.Global.ok :
                                                Localizationable.Global.retry).localized,
                                      style: .cancel,
                                      handler: { _ in info.handler?() }))
        UIApplication.getTopViewController()?.present(alert, animated: true, completion: completion)
    }
    
    fileprivate func getFeedback(with type: AlertType) {
        switch type {
        case .warning:
            hapticFeedbackService?.generate.onNext(.warning)
        case .error, .networkError:
            hapticFeedbackService?.generate.onNext(.error)
        }
    }
}
