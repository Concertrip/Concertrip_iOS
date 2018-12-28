//
//  Events.swift
//  Concertrip
//
//  Created by 심지원 on 2018. 12. 28..
//  Copyright © 2018년 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct Events : Mappable {
    var eventId : String?
    var eventTitle : String?
    var eventLocation : String?
    var eventDate : String?
    var eventTag : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        eventId <- map["_id"]
        eventTitle <- map["title"]
        eventLocation <- map["location"]
        eventDate <- map["date"]
        eventTag <- map["tag"]
    }
    
}
