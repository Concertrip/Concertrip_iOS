//
//  Detail.swift
//  Concertrip
//
//  Created by 양어진 on 02/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct Detail : Mappable {
    var detailId : String?
    var detailName : String?
    var detailProfileImg : String?
    var detailSubscribe : Bool?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        detailId <- map["_id"]
        detailName <- map["name"]
        detailProfileImg <- map["profileImg"]
        detailSubscribe <- map["subscribe"]
    }
    
}
