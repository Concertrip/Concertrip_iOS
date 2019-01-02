//
//  DetailArtist.swift
//  Concertrip
//
//  Created by 양어진 on 02/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//
import Foundation
import ObjectMapper

struct DetailArtist : Mappable {
    var artistId : String?
    var artistProfileImg : String?
    var artistBackImg : String?
    var artistName : String?
    var artistIsSubscribe : Bool?
    var artistSubscribeNum : Int?
    var artistYoutubeUrl : String?
    var artistList : [Detail]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        artistId <- map["_id"]
        artistProfileImg <- map["profileImg"]
        artistBackImg <- map["backImg"]
        artistName <- map["name"]
        artistIsSubscribe <- map["isSubscribe"]
        artistSubscribeNum <- map["subscribeNum"]
        artistYoutubeUrl <- map["youtubeUrl"]
        artistList <- map["eventList"]
    }
    
}
