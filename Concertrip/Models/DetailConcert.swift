//
//  DetailConcert.swift
//  Concertrip
//
//  Created by 양어진 on 06/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct DetailConcert: Mappable {
    var dConcertId: String?
    var dConcertSubscribe: Bool?
    var dConcertProfileImg: String?
    var dConcertBackImg: String?
    var dConcertName: String?
    var dConcertSubscribeNum: Int?
    var dConcertYoutubeUrl: String?
    var dConcertLocation: String?
    var dConcertMemberList: [MemberList]?
    var dConcertDate: [String]?
    var dConcertSeatName: [String]?
    var dConcertSeatPrice: [String]?
    var dConcertPrecautionList: [PrecautionList]?
    var dConcertEventInfoImg: String?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        dConcertId <- map["_id"]
        dConcertSubscribe <- map["subscribe"]
        dConcertProfileImg <- map["profileImg"]
        dConcertBackImg <- map["backImg"]
        dConcertName <- map["name"]
        dConcertSubscribeNum <- map["subscribeNum"]
        dConcertYoutubeUrl <- map["youtubeUrl"]
        dConcertLocation <- map["location"]
        dConcertMemberList <- map["memberList"]
        dConcertDate <- map["date"]
        dConcertSeatName <- map["seatName"]
        dConcertSeatPrice <- map["seatPrice"]
        dConcertPrecautionList <- map["precautionList"]
        dConcertEventInfoImg <- map["eventInfoImg"]
    }
}
