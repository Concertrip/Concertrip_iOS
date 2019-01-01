//
//  Genres.swift
//  Concertrip
//
//  Created by 심지원 on 2019. 1. 1..
//  Copyright © 2019년 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct Genres : Mappable {
    var genreId : String?
    var genreName : String?
    var genreProfileImg : String?
    var genreFilter : [String]?
    var genreSubscribe : Bool?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        genreId <- map["_id"]
        genreName <- map["name"]
        genreProfileImg <- map["profileImg"]
        genreFilter <- map["filter"]
        genreSubscribe <- map["subscribe"]
    }
    
}
