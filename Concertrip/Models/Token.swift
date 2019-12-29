//
//  Token.swift
//  Concertrip
//
//  Created by 심지원 on 2018. 12. 27..
//  Copyright © 2018년 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct Token: Mappable {
    
    var token: String?
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        token <- map["token"]
    }
}
