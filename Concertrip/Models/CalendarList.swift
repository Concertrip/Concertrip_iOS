//
//  CalendarList.swift
//  Concertrip
//
//  Created by 양어진 on 06/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct CalendarList : Mappable {
    var calendarId : String?
    var calendarTabId : String?
    var calendarName : String?
    var calendarProfileImg : String?
    var calendarDate : [String]?
    var calendarTag : String?
    var calendarSubscribe : Bool?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        calendarId <- map["_id"]
        calendarTabId <- map["tabId"]
        calendarName <- map["name"]
        calendarProfileImg <- map["profileImg"]
        calendarDate <- map["date"]
        calendarTag <- map["hashTag"]
        calendarSubscribe <- map["subscribe"]
    }
    
}
