//
//  Data.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import Foundation

extension Data {
    public func convertToDictionary() -> [String: Any]? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
