//
//  CalendarTap.swift
//  Concertrip
//
//  Created by 양어진 on 05/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct CalendarTap : Mappable {
    var calTapId : String?
    var calTapType : String?
    var calTapName : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        calTapId <- map["_id"]
        calTapType <- map["type"]
        calTapName <- map["name"]
    }
    
}
