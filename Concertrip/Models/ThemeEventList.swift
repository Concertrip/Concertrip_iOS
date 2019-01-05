//
//  ThemeEventList.swift
//  Concertrip
//
//  Created by 양어진 on 05/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

//import Foundation
//import ObjectMapper
//
//struct ThemeEventList : Mappable {
//    var eventId : String?
//    var eventName : String?
//    var eventProfileImg : String?
//    var eventFilter : [String]?
//    var eventSubscribe : Bool?
//
//    init?(map: Map) {
//
//    }
//
//    mutating func mapping(map: Map) {
//
//        eventId <- map["_id"]
//        eventName <- map["name"]
//        eventProfileImg <- map["profileImg"]
//        eventFilter <- map["filter"]
//        eventSubscribe <- map["subscribe"]
//    }
//
//}

import Foundation
import ObjectMapper

struct ThemeEventList : Mappable {
    var eventId : String?
    var eventName : String?
    var eventProfileImg : String?
    var eventSubscribe : Bool?
    var eventTag : String?
    var eventGroup : Bool?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        eventId <- map["_id"]
        eventName <- map["name"]
        eventProfileImg <- map["profileImg"]
        eventSubscribe <- map["subscribe"]
        eventTag <- map["tag"]
        eventGroup <- map["group"]
    }
    
}
