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
        "Authorization" : "2"
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
