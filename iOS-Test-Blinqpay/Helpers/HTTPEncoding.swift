//
//  HTTPEncoding.swift
//  iOS-Test-Blinqpay
//
//  Created by Mark Boleigha on 24/03/2022.
//  Copyright © 2022 Blinqpay. All rights reserved.
//

import Foundation
import Alamofire

enum HTTPEncoding {
    case json
    case url
    case urlJson
    case upload
    
    var get: ParameterEncoding {
        switch self {
        case .json, .upload:
            return JSONEncoding.default
        case .url, .urlJson:
            return URLEncoding.default
        }
    }
    
    var contentType: (name: String, value: String) {
        switch self {
        case .json, .urlJson:
            return (name: "Content-Type", value: "application/json")
        case .url:
            return (name: "Content-Type", value: "application/x-www-form-urlencoded")
        case .upload:
            return (name: "Content-type", value: "multipart/form-data")
        }
    }
}
