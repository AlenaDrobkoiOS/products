//
//  DetailsCellModel.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import Foundation

/// DetailsCell type with data model: image, text and button
enum DetailsCellModel {
    case image(String?)
    case text(TextCellModel)
}

extension DetailsCellModel: Equatable {
    static func == (lhs: DetailsCellModel, rhs: DetailsCellModel) -> Bool {
        switch (lhs, rhs) {
        case (.image(let lhsURL), .image(let rhsURL)):
            return lhsURL == rhsURL
        case (.text(let lhsModel), .text(let rhsModel)):
            return lhsModel == rhsModel
        default:
            return false
        }
    }
}
