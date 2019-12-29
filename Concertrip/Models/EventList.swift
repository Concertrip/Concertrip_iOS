//
//  EventList.swift
//  Concertrip
//
//  Created by 양어진 on 06/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct EventList: Mappable {
    var eventId: String?
    var eventName: String?
    var eventProfileImg: String?
    var eventSubscribe: Bool?
    var eventTag: String?
    var isGroup: Bool?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        eventId <- map["_id"]
        eventName <- map["name"]
        eventProfileImg <- map["profileImg"]
        eventSubscribe <- map["subscribe"]
        eventTag <- map["hashTag"]
        isGroup <- map["group"]
    }
}
