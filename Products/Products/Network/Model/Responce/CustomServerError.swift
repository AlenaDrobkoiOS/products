//
//  CustomServerError.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import Foundation

/// Kinds of network error
public enum CustomServerError: Error {
    case warning(warning: String)
    case serverError(error: String)
    case invalidAccessToken(dispatchedToken: String?, serverMessage: String)
}

extension CustomServerError: LocalizedError {
    var localizedDescription: String? {
        switch self {
        case let .warning(warning):
            return "Warning: \(warning)"
        case let .serverError(error):
            return error
        case let .invalidAccessToken(dispatchedToken, serverMessage):
            return
                """
                Invalid Access TOKEN:  \(dispatchedToken ?? "TOKEN IS NIL"),
                Server message: \(serverMessage)"
                """
        }
    }
}
