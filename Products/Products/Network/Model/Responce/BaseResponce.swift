//
//  BaseResponce.swift
//  Products
//
//  Created by Alena Drobko on 05.08.23.
//

import Foundation

/// Protocol for responce data
public protocol BaseResponseProtocol: Codable {
    var code: String? { get set }
    var message: String? { get set }
}

/// Base responce data model - contains info that comes with any responce
struct BaseResponse: BaseResponseProtocol {
    var code: String?
    var message: String?
}
