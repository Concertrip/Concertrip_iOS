//
//  TicketComming.swift
//  Concertrip
//
//  Created by 양어진 on 11/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import Foundation
import ObjectMapper

struct TicketComming: Mappable {
    var ticketId: Int?
    var ticketName: String?
    var ticketLocation: String?
    var ticketDate: String?
    var ticketSeat: String?
    var ticketUserIdx: Int?
    var ticketEventId: String?
    var ticketNow: String?
    var ticketPurchaseUrl: String?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        ticketId <- map["_id"]
        ticketName <- map["name"]
        ticketLocation <- map["location"]
        ticketDate <- map["date"]
        ticketSeat <- map["seat"]
        ticketUserIdx <- map["userIdx"]
        ticketEventId <- map["eventId"]
        ticketNow <- map["now"]
        ticketPurchaseUrl <- map["purchaseUrl"]
    }
}
