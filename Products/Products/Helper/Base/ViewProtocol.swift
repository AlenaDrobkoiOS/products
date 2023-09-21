//
//  ViewProtocol.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import Foundation

/// Base protocol for all custom view
public protocol ViewProtocol: DeinitLoggerType {
    associatedtype ViewModelType: ViewModelProtocol
    
    var viewModel: ViewModelType! { get set }

    func setupOutput()
    func setupInput(input: ViewModelType.Output)
}
