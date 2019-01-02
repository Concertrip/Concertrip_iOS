//
//  SubscribeDetail.swift
//  Concertrip
//
//  Created by 양어진 on 02/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct SubscribeDetail : Mappable {
    var subDetailId : String?
    var subDetailProfileImg : String?
    var subDetailBackImg : String?
    var subDetailName : String?
    var isSubscribe : Bool?
    var subscribeNum : Int?
    var youtubeUrl : String?
    var eventList : [EventList]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        _id <- map["_id"]
        profileImg <- map["profileImg"]
        backImg <- map["backImg"]
        name <- map["name"]
        isSubscribe <- map["isSubscribe"]
        subscribeNum <- map["subscribeNum"]
        youtubeUrl <- map["youtubeUrl"]
        eventList <- map["eventList"]
    }
    
}
