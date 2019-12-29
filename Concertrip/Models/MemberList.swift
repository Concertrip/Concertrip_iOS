//
//  MemberList.swift
//  Concertrip
//
//  Created by 양어진 on 06/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct MemberList: Mappable {
    var memId: String?
    var memName: String?
    var memProfileImg: String?
    var memSubscribe: Bool?
    var memTag: String?
    var memGroup: Bool?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        memId <- map["_id"]
        memName <- map["name"]
        memProfileImg <- map["profileImg"]
        memSubscribe <- map["subscribe"]
        memTag <- map["tag"]
        memGroup <- map["group"]
    }
}
