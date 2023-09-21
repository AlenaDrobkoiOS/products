//
//  Reusable.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import Foundation

public protocol Reusable {
    static var reuseID: String { get }
}

public extension Reusable {
    static var reuseID: String {
        return String(describing: self)
    }
}
