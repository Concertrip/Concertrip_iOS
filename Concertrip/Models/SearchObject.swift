//
//  SearchObject.swift
//  Concertrip
//
//  Created by 심지원 on 2019. 1. 1..
//  Copyright © 2019년 양어진. All rights reserved.
//


import Foundation
import ObjectMapper

struct SearchObject: Mappable {
    var artists: [Artists]?
    var events: [Events]?
    var genres: [Genres]?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        artists <- map["artists"]
        events <- map["events"]
        genres <- map["genres"]
    }
    
}
