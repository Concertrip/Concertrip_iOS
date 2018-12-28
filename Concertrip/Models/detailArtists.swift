//
//  Artists.swift
//  Concertrip
//
//  Created by 심지원 on 2018. 12. 27..
//  Copyright © 2018년 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct detailArtist : Mappable {
    var artistId : String?
    var artistSubscribeNum : Int?
    var artistName : String?
    var artistProfileImg : String?
    var artistBackImg : String?
    var artsitTag : String?
    var artistYoutubeUrl : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        artistId <- map["_id"]
        artistSubscribeNum <- map["subscribeNum"]
        artistName <- map["name"]
        artistProfileImg <- map["profileImg"]
        artistBackImg <- map["backImg"]
        artsitTag <- map["tag"]
        artistYoutubeUrl <- map["youtubeUrl"]
    }
    
}
