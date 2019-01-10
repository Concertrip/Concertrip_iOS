//
//  CalendarListService.swift
//  Concertrip
//
//  Created by 양어진 on 06/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import Foundation
import Alamofire

struct CalendarListService: APIManager, Requestable{
    typealias NetworkData = ResponseArray<CalendarList>
    static let shared = CalendarListService()
    var calendarURL = url("/api/calendar")
    let header: HTTPHeaders = [
        "Authorization" : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjb25jZXJ0cmlwIiwidXNlcklkeCI6Mn0.Hc9kqk1lE4H1gMXxsTLt50GTP2wpPPv_x4TzuTMM2o8"
    ]

    func getCalendarMonthly(type: String, id: String, year: Int, month: Int, completion: @escaping ([CalendarList]) -> Void) {
        let monthListURL = calendarURL + "/type?type=\(type)&id=\(id)&year=\(year)&month=\(month)"
        gettable(monthListURL, body: nil, header: header) { (res) in
            switch res {
            case .success(let value):
                guard let monthList = value.data else
                {return}
                completion(monthList)
            case .error(let error):
                print(error)
            }
        }
    }
    
//    /api/calendar/day?type=all&id=&year=2019&month=1&day=26
    
    func getCalendarDaily(type: String, id: String, year: Int, month: Int, day:Int, completion: @escaping ([CalendarList]) -> Void) {
        let monthListURL = calendarURL + "/day?type=\(type)&id=\(id)&year=\(year)&month=\(month)&day=\(day)"
        gettable(monthListURL, body: nil, header: header) { (res) in
            switch res {
            case .success(let value):
                guard let monthList = value.data else
                {return}
                completion(monthList)
            case .error(let error):
                print(error)
            }
        }
    }
    
}

