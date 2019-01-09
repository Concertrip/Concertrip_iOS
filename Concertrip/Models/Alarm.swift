//
//  Alarm.swift
//  Concertrip
//
//  Created by 양어진 on 09/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct Alarm : Mappable {
    var alarmId : Int?
    var alarmUserIdx : Int?
    var alarmTitle : String?
    var alarmBody : String?
    var alarmCreatedAt : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        alarmId <- map["id"]
        alarmUserIdx <- map["userIdx"]
        alarmTitle <- map["title"]
        alarmBody <- map["body"]
        alarmCreatedAt <- map["createdAt"]
    }
    
}
