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
}

