//
//  DetailTheme.swift
//  Concertrip
//
//  Created by 양어진 on 05/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct DetailTheme : Mappable {
    var dThemeId : String?
    var dThemeProfileImg : String?
    var dThemeBackImg : String?
    var dThemeName : String?
    var dThemeIsSubscribe : Bool?
    var dThemeSubscribeNum : Int?
    var dThemeYoutubeUrl : String?
    var dThemeEventList : [ThemeEventList]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        dThemeId <- map["_id"]
        dThemeProfileImg <- map["profileImg"]
        dThemeBackImg <- map["backImg"]
        dThemeName <- map["name"]
        dThemeIsSubscribe <- map["isSubscribe"]
        dThemeSubscribeNum <- map["subscribeNum"]
        dThemeYoutubeUrl <- map["youtubeUrl"]
        dThemeEventList <- map["eventList"]
    }
    
}
