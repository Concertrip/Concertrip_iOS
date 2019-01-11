//
//  Notifications.swift
//  Concertrip
//
//  Created by 심지원 on 2019. 1. 12..
//  Copyright © 2019년 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct Notifications : Mappable {
    var noticeId : Int?
    var userIdx : Int?
    var noticeTitle : String?
    var noticeBody : String?
    var noticeCreatedAt : String?
    var noticeImg : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        noticeId <- map["id"]
        userIdx <- map["userIdx"]
        noticeTitle <- map["title"]
        noticeBody <- map["body"]
        noticeCreatedAt <- map["createdAt"]
        noticeImg <- map["noticeImg"]
    }
    
}
