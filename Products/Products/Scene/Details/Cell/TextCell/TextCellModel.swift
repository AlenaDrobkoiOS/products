//
//  TextCellModel.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import Foundation

/// Details screen text cell types: title, price, content
enum TextCellModel {
    case title(String?)
    case price(price: Double, strokePrice: Double?)
    case content(String?)
}

extension TextCellModel: Equatable {
    static func == (lhs: TextCellModel, rhs: TextCellModel) -> Bool {
        switch (lhs, rhs) {
        case (.title(let lhsText), .title(let rhsText)):
            return lhsText == rhsText
        case (.price(let lhsPrice, let lhsStrokePrice), .price(let rhsPrice, let rhsStrokePrice)):
            return lhsPrice == rhsPrice && lhsStrokePrice == rhsStrokePrice
        case (.content(let lhsText), .content(let rhsText)):
            return lhsText == rhsText
        default:
            return false
        }
    }
}
