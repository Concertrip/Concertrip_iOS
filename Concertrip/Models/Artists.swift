//
//  Artists.swift
//  Concertrip
//
//  Created by 심지원 on 2018. 12. 28..
//  Copyright © 2018년 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct Artists : Mappable {
    var artistId : String?
    var artistName : String?
    var artistTag : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        artistId <- map["_id"]
        artistName <- map["name"]
        artistTag <- map["tag"]
    }
    
}
