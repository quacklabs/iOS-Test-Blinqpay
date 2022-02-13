//
//  Story.swift
//  iOS-Test-Blinqpay
//
//  Created by Mark Boleigha on 11/02/2022.
//  Copyright © 2022 Blinqpay. All rights reserved.
//

import Foundation

struct Story: Codable {
    var caption: String
    var id: String
    var timestamp: Int64
    var url: String
    var video: Bool
    
    enum CodingKeys: String, CodingKey {
        case caption, id, timestamp, url, video
    }
    
    init(from decoder: Decoder) throws {
        let values = try! decoder.container(keyedBy: CodingKeys.self)
        
        caption = try values.decode(String.self, forKey: .caption)
        id = try values.decode(String.self, forKey: .id)
        timestamp = try values.decode(Int64.self, forKey: .timestamp)
        url = try values.decode(String.self, forKey: .url)
        video = try values.decode(Bool.self, forKey: .video)
    }
}
