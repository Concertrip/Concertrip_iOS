//
//  TabTheme.swift
//  Concertrip
//
//  Created by 심지원 on 2019. 1. 10..
//  Copyright © 2019년 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct TabTheme : Mappable {
    var themeId : String?
    var themeName : String?
    var themeProfileImg : String?
    var themeSubscribe : Bool?
    var themeTag : String?
    var themeGroup : Bool?
    var themeHashtag : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        themeId <- map["_id"]
        themeName <- map["name"]
        themeProfileImg <- map["profileImg"]
        themeSubscribe <- map["subscribe"]
        themeTag <- map["tag"]
        themeGroup <- map["group"]
        themeHashtag <- map["hashtag"]
    }
    
}
