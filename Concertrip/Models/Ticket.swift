//
//  Ticket.swift
//  Concertrip
//
//  Created by 양어진 on 01/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct Ticket : Mappable {
    var ticketId : Int?
    var ticketName : String?
    var ticketLocation : String?
    var ticketDate : String?
    var ticketSeat : String?
    var ticketUserIdx : Int?
    var ticketEventId : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        ticketId <- map["_id"]
        ticketName <- map["name"]
        ticketLocation <- map["location"]
        ticketDate <- map["date"]
        ticketSeat <- map["seat"]
        ticketUserIdx <- map["userIdx"]
        ticketEventId <- map["eventId"]
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss.SSSZ"
//
//        if let dateString = map["date"].currentValue as? String,
//            let _date = dateFormatter.date(from: dateString) {
//            ticketDate = _date
//        }
    }
    
}
