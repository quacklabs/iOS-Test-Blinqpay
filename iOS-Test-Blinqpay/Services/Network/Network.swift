//
//  Network.swift
//  iOS-Test-Blinqpay
//
//  Created by Mark Boleigha on 24/03/2022.
//  Copyright © 2022 Blinqpay. All rights reserved.
//

import Foundation
import RxSwift

protocol NetworkService {
    func fetch<T: Codable>(_ request: NetworkRequest) -> Observable<(NetworkResponse, T?)>
    func push<T: Codable>(_ request: NetworkRequest) -> Observable<(NetworkResponse, CGFloat?, T?)>
//    func download<T: Codable>()
}

// Just so we can test with stubbed data, we abstract this on top of our actual network request.
class Network {
    
    static let shared = Network(service: Request())
    var service: NetworkService!
    
    init(service: NetworkService) {
        self.service = service
    }
    
    func fetch<T>(_ request: NetworkRequest) -> Observable<(NetworkResponse, T?)> where T : Decodable, T : Encodable {
        return self.service.fetch(request)
    }
    
    func push<T: Codable>(_ request: NetworkRequest) -> Observable<(NetworkResponse, CGFloat?, T?)> {
        return self.service.push(request)
    }
}
