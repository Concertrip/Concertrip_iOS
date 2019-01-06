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
        "Authorization" : "1"
    ]

    func getCalendarMonthly(type: String, id: String, year: String, month: String, completion: @escaping ([CalendarList]) -> Void) {
        let monthListURL = calendarURL + "/type"
        
        print("getCalendarMonthly입니다.")
        gettable(monthListURL, body: nil, header: header) { (res) in
            print("gettable res :\(res)")
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

