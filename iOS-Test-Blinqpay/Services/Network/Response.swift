//
//  Response.swift
//  iOS-Test-Blinqpay
//
//  Created by Mark Boleigha on 24/03/2022.
//  Copyright © 2022 Blinqpay. All rights reserved.
//

import Foundation

struct Response<T: Codable>: Codable {
    var status: Bool?
    var error: String?
    var code: Int?
    var message: String?
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case status, message, code, data, error
    }
    
    init(from decoder: Decoder) throws {
        let values = try! decoder.container(keyedBy: CodingKeys.self)
        
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        data = try values.decodeIfPresent(T.self, forKey: .data)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }
}
