//
//  AuthorizationTokenProvider.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import Foundation

/// Protocol for any token, api key or another auth kind provider
public protocol AuthorizationTokenProvider {
    func token() -> String?
}
