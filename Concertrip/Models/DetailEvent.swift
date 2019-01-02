//
//  DetailEvent.swift
//  Concertrip
//
//  Created by 양어진 on 02/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct DetailEvent : Mappable {
    var eventId : String?
    var eventProfileImg : String?
    var eventBackImg : String?
    var eventName : String?
    var eventIsSubscribe : Bool?
    var eventSubscribeNum : Int?
    var eventYoutubeUrl : String?
    var eventList : [Detail]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        eventId <- map["_id"]
        eventProfileImg <- map["profileImg"]
        eventBackImg <- map["backImg"]
        eventName <- map["name"]
        eventIsSubscribe <- map["isSubscribe"]
        eventSubscribeNum <- map["subscribeNum"]
        eventYoutubeUrl <- map["youtubeUrl"]
        eventList <- map["eventList"]
    }
    
}
