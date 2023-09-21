//
//  String.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "\(self)_comment")
    }
}
