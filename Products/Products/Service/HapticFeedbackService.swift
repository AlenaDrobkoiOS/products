//
//  HapticFeedbackService.swift
//  Products
//
//  Created by Alena Drobko on 06.08.23.
//

import UIKit
import RxSwift

// Haptic Feedback types: swipe, selected, success, warning or error
enum HapticFeedbackType {
    case swipe
    case selected
    case warning
    case error
    case success
}

/// Alert Service protocol
protocol HapticFeedbackServiceType: Service {
    var generate: PublishSubject<HapticFeedbackType> { get }
}

/// Service that helps with showing alert
final class HapticFeedbackService: HapticFeedbackServiceType {
    
    private lazy var selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    private lazy var notificationFeedbackGenerator = UINotificationFeedbackGenerator()
    private lazy var impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    
    var generate: PublishSubject<HapticFeedbackType> = PublishSubject()
    
    private let bag = DisposeBag()
    
    init() {
        generate
            .asObservable()
            .bind { [weak self] type in
                guard let self else { return }
                
                switch type {
                case .swipe:
                    self.impactFeedbackGenerator.impactOccurred(intensity: 0.2)
                case .selected:
                    self.selectionFeedbackGenerator.selectionChanged()
                case .warning:
                    self.notificationFeedbackGenerator.notificationOccurred(.warning)
                case .error:
                    self.notificationFeedbackGenerator.notificationOccurred(.error)
                case .success:
                    self.notificationFeedbackGenerator.notificationOccurred(.success)
                }
            }
            .disposed(by: bag)
    }
}
