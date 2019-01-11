//
//  Subscribe.swift
//  Concertrip
//
//  Created by 양어진 on 02/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct Subscribe : Mappable {
    var id : String?
    var name : String?
    var profileImg : String?
    var isSubscribe : Bool?
    var isGroup : Bool?
    var hashTag : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["_id"]
        name <- map["name"]
        profileImg <- map["profileImg"]
        isSubscribe <- map["subscribe"]
        isGroup <- map["group"]
        hashTag <- map["hashTag"]
    }
    
}

//{
//    "_id": "5c35c689edc59445b3da6a05",
//    "name": "2018 이문세 ‘The Best’",
//    "profileImg": "https://s3.ap-northeast-2.amazonaws.com/hyeongbucket/2018+%EC%9D%B4%EB%AC%B8%EC%84%B8+%E2%80%98The+Best%E2%80%99/%ED%94%84%EB%A1%9C%ED%95%84.gif",
//    "subscribe": true,
//    "tag": null,
//    "group": false,
//    "hashTag": "#12월 29일 - 12월 30일 #서울"
//}
