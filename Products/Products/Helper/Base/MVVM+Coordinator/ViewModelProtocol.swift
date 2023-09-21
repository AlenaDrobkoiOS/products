//
//  ViewModelProtocol.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import Foundation

///Base protocol for all view model
public protocol ViewModelProtocol: DeinitLoggerType {
    associatedtype Input
    associatedtype Output

    func transform(_ input: Input,
                   outputHandler: @escaping (_ output: Output) -> Void)
}
