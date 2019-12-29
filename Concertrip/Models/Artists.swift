//
//  Artists.swift
//  Concertrip
//
//  Created by 심지원 on 2019. 1. 1..
//  Copyright © 2019년 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct Artists: Mappable {
    var artistId: String?
    var artistName: String?
    var artistProfileImg: String?
    var artistSubscribe: Bool?
    var artistIsGroup: Bool?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        artistId <- map["_id"]
        artistName <- map["name"]
        artistProfileImg <- map["profileImg"]
        artistSubscribe <- map["subscribe"]
        artistIsGroup <- map["group"]
    }
    
}
