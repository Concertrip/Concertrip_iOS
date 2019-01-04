//
//  DetailEventList.swift
//  Concertrip
//
//  Created by 양어진 on 05/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct DetailEventList : Mappable {
    var eventId : String?
    var eventName : String?
    var eventProfileImg : String?
    var eventFilter : [String]?
    var eventSubscribe : Bool?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        eventId <- map["_id"]
        eventName <- map["name"]
        eventProfileImg <- map["profileImg"]
        eventFilter <- map["filter"]
        eventSubscribe <- map["subscribe"]
    }
    
}
