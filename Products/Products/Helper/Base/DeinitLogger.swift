//
//  DeinitLogger.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import Foundation

/// Helps to log deinit of clases
public protocol DeinitLoggerType: AnyObject {
    func setupDeinitAnnouncer()
}

private var announcerKey = "announcer_key"

public extension DeinitLoggerType {
    func setupDeinitAnnouncer() {
        let announcer = DeinitLogger(object: self)
        objc_setAssociatedObject(self, &announcerKey, announcer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

private final class DeinitLogger {
    private let className: String

    init(object: AnyObject) {
        self.className = String(describing: object.self)
    }

    deinit {
        debugPrint("DEINITED: \(className)")
    }
}
