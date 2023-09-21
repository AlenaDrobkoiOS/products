//
//  Localizationable.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import Foundation

protocol LocalizableDelegate {
    var rawValue: String { get } //localize key
    var localized: String { get }
}

extension LocalizableDelegate {
    ///returns a localized value by specified key located in the specified table
    var localized: String {
        return rawValue.localized
    }
}

/// Helps with localization
enum Localizationable {
    enum Global: String, LocalizableDelegate {
        case error = "Global.error"
        case warning = "Global.warning"
        case ok = "Global.OK"
        case urlWarning = "Global.urlWarning"
        case retry = "Global.retry"
    }
    
    enum Product: String, LocalizableDelegate {
        case actionPrice = "Product.actionPrice"
        case euro = "Product.euro"
        case loading = "Product.loading"
    }
}
