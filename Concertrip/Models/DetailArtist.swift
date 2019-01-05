//
//  DetailArtist.swift
//  Concertrip
//
//  Created by 양어진 on 05/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct DetailArtist : Mappable {
    var dArtistId : String?
    var dArtistProfileImg : String?
    var dArtistBackImg : String?
    var dArtistName : String?
    var dArtistSubscribeNum : Int?
    var dYoutubeUrl : String?
    var dMemberList : [MemberList]?
    var dEventsList : [EventList]?
    var dSubscribe : Bool?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        dArtistId <- map["_id"]
        dArtistProfileImg <- map["profileImg"]
        dArtistBackImg <- map["backImg"]
        dArtistName <- map["name"]
        dArtistSubscribeNum <- map["subscribeNum"]
        dYoutubeUrl <- map["youtubeUrl"]
        dMemberList <- map["memberList"]
        dEventsList <- map["eventsList"]
        dSubscribe <- map["subscribe"]
    }
    
}
