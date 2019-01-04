//
//  DetailArtist.swift
//  Concertrip
//
//  Created by 양어진 on 04/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct DetailArtist : Mappable {
    var dArtistId : String?
    var dProfileImg : String?
    var dBackImg : String?
    var dName : String?
    var dIsSubscribe : Bool?
    var dSubscribeNum : Int?
    var dYoutubeUrl : String?
    var dEventList : [DetailEventList]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        dArtistId <- map["_id"]
        dProfileImg <- map["profileImg"]
        dBackImg <- map["backImg"]
        dName <- map["name"]
        dIsSubscribe <- map["isSubscribe"]
        dSubscribeNum <- map["subscribeNum"]
        dYoutubeUrl <- map["youtubeUrl"]
        dEventList <- map["eventList"]
    }
    
}
