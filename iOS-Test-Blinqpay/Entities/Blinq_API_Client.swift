//
//  Blinq_API_Client.swift
//  iOS-Test-Blinqpay
//
//  Created by Mark Boleigha on 24/03/2022.
//  Copyright © 2022 Blinqpay. All rights reserved.
//
import Foundation
import Alamofire

protocol Microservice {
    var url: URL? { get }
    var stringValue: String { get }
    var method: String? { get }
}

enum Blinq_API_Client: Microservice {
    
    case _def
    
    var stringValue: String {
        return ""
    }
    
    var url : URL? {
        guard let _url = URL(string: self.stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
            return nil
        }
        return _url
    }
    
    var method: String? { return nil }
}
