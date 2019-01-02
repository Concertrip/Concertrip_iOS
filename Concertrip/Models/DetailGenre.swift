//
//  DetailGenre.swift
//  Concertrip
//
//  Created by 양어진 on 02/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct DetailGenre : Mappable {
    var themeId : String?
    var themeProfileImg : String?
    var themeBackImg : String?
    var themeName : String?
    var themeIsSubscribe : Bool?
    var themeSubscribeNum : Int?
    var themeYoutubeUrl : String?
    var themeList : [Detail]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        themeId <- map["_id"]
        themeProfileImg <- map["profileImg"]
        themeBackImg <- map["backImg"]
        themeName <- map["name"]
        themeIsSubscribe <- map["isSubscribe"]
        themeSubscribeNum <- map["subscribeNum"]
        themeYoutubeUrl <- map["youtubeUrl"]
        themeList <- map["eventList"]
    }
    
}
