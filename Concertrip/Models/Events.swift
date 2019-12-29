//
//  Events.swift
//  Concertrip
//
//  Created by 심지원 on 2019. 1. 1..
//  Copyright © 2019년 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct Events: Mappable {
    var eventId: String?
    var eventName: String?
    var eventProfileImg: String?
    var eventTag: String?
    var eventSubscribe: Bool?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        eventId <- map["_id"]
        eventName <- map["name"]
        eventProfileImg <- map["profileImg"]
        eventTag <- map["hashTag"]
        eventSubscribe <- map["subscribe"]
    }
    
}
