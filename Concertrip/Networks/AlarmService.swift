//
//  AlarmService.swift
//  Concertrip
//
//  Created by 양어진 on 09/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//
import Foundation
import Alamofire

struct AlarmService: APIManager, Requestable {
    typealias NetworkData = Alarm
    static let shared = AlarmService()
    let queryURL = url("/api/fcm/list")
    let header: HTTPHeaders = [
        "Content-Type": "application/json",
        "Authorization": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjb25jZXJ0cmlwIiwidXNlcklkeCI6MX0.qDnh3VXMVAoKzWqeXzDwH9heZoRbL1AO6dy2FgieviI"
    ]
    
    func getAlarmData(completion: @escaping ([Alarm]) -> Void) {
        gettable(queryURL, body: nil, header: header) { (res) in
            print("alarm Res : \(res)")
            switch res {
            case .success(let value):
//                guard let ticketList = value. else
//                {return}
//                print("ticketList : \(ticketList.count)")
                
                completion([value])
            case .error(let error):
                print("에러엘어ㅔ러 : \(error)")
            }
        }
    }
}

