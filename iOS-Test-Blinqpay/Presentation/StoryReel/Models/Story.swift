//
//  Story.swift
//  iOS-Test-Blinqpay
//
//  Created by Mark Boleigha on 28/03/2022.
//  Copyright © 2022 Blinqpay. All rights reserved.
//

import Foundation

//
//  Story.swift
//  iOS-Test-Blinqpay
//
//  Created by Mark Boleigha on 11/02/2022.
//  Copyright © 2022 Blinqpay. All rights reserved.
//

import Foundation
import UIKit
import RxDataSources

struct StoryGroup: Codable {
    var user_id: String
    var items: [Story]
}

enum StoryType: Int, Codable {
    case image = 1
    case video = 2
}

struct Story: Codable {
    var caption: String?
    var content: String
    var duration: Int
    var privacy: Int
    var repostedFromId: String?
    var seenCount: Int64 = 0
    var seenCountSent: Bool = false
    var seenByUserIds: [String]?
    var textStatus: String?
    var statusId: String
    var thumbImg: String
    var thumbnail: String?
    var timestamp: Int64
    var type: StoryType
    var updateTimestamp: Int64
    var userId: String
    
    enum CodingKeys: String, CodingKey {
        case caption, content, duration, privacy, repostedFromId, seenCount, seenCountSent, seenByUserIds, textStatus, statusId
        case thumbImg, thumbnail, timestamp, type, updateTimestamp, userId
    }
    
    
    init(from decoder: Decoder) throws {
        let values = try! decoder.container(keyedBy: CodingKeys.self)
        
        caption = try values.decodeIfPresent(String.self, forKey: .caption)
        content = try values.decode(String.self, forKey: .content)
        duration = try values.decode(Int.self, forKey: .duration)
        privacy = try values.decode(Int.self, forKey: .privacy)
        repostedFromId = try values.decodeIfPresent(String.self, forKey: .repostedFromId)
        seenCount = try values.decode(Int64.self, forKey: .seenCount)
        seenCountSent = try values.decode(Bool.self, forKey: .seenCountSent)
        seenByUserIds = try values.decodeIfPresent([String].self, forKey: .seenByUserIds)
        textStatus = try values.decodeIfPresent(String.self, forKey: .textStatus)
        statusId = try values.decode(String.self, forKey: .statusId)
        thumbImg = try values.decode(String.self, forKey: .statusId)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
        timestamp = try values.decode(Int64.self, forKey: .timestamp)
        type = try values.decode(StoryType.self, forKey: .type)
        updateTimestamp = try values.decode(Int64.self, forKey: .updateTimestamp)
        userId = try values.decode(String.self, forKey: .userId)
    }
}

extension Story : IdentifiableType, Equatable{
    
    typealias Identity = String
    
    var identity: Identity {
        return statusId
    }
    
    static func ==(lhs: Story, rhs: Story) -> Bool {
        return lhs.statusId == rhs.statusId
    }
}

extension Story : Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(statusId)
    }
}
