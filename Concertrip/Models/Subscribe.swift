//
//  Subscribe.swift
//  Concertrip
//
//  Created by 양어진 on 02/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct Subscribe: Mappable {
    var id: String?
    var name: String?
    var profileImg: String?
    var isSubscribe: Bool?
    var isGroup: Bool?
    var hashTag: String?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["_id"]
        name <- map["name"]
        profileImg <- map["profileImg"]
        isSubscribe <- map["subscribe"]
        isGroup <- map["group"]
        hashTag <- map["hashTag"]
    }
}
