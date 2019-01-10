//
//  CalendarService.swift
//  Concertrip
//
//  Created by 양어진 on 05/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import Foundation
import Alamofire

struct CalendarTapService: APIManager, Requestable{
    typealias NetworkData = ResponseArray<CalendarTap>
    static let shared = CalendarTapService()
    var calendarURL = url("/api/calendar")
    let header: HTTPHeaders = [
        "Authorization" : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjb25jZXJ0cmlwIiwidXNlcklkeCI6Mn0.Hc9kqk1lE4H1gMXxsTLt50GTP2wpPPv_x4TzuTMM2o8"
    ]
    
    
    func getCalendarTap(completion: @escaping ([CalendarTap]) -> Void) {
        let tapURL = calendarURL + "/tab"
        gettable(tapURL, body: nil, header: header) { (res) in
            switch res {
            case .success(let value):
                guard let tapList = value.data else
                {return}
                completion(tapList)
            case .error(let error):
                print(error)
            }
        }
    }
}
