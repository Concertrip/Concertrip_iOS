//
//  Events.swift
//  Concertrip
//
//  Created by 심지원 on 2018. 12. 27..
//  Copyright © 2018년 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct detailEvents: Mappable {
    var eventId : String?
    var eventSubscribeNum : Int?
    var eventTitle : String?
    var eventProfileImg : String?
    var eventBackImg : String?
    var eventLocation : String?
    var eventTag : String?
    var eventCast : String?
    var eventDate : String?
    var eventPrice : Int?
    var eventYoutubeUrl : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        eventId <- map["_id"]
        eventSubscribeNum <- map["subscribeNum"]
        eventTitle <- map["title"]
        eventProfileImg <- map["profileImg"]
        eventBackImg <- map["backImg"]
        eventLocation <- map["location"]
        eventTag <- map["tag"]
        eventCast <- map["cast"]
        eventDate <- map["date"]
        eventPrice <- map["price"]
        eventYoutubeUrl <- map["youtubeUrl"]
    }
    
}
