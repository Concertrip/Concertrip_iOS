//
//  AlarmService.swift
//  Concertrip
//
//  Created by 양어진 on 09/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//
import Foundation
import Alamofire

struct AlarmService: APIManager, Requestable{
    typealias NetworkData = ResponseArray<Alarm>
    static let shared = AlarmService()
    var alarmURL = url("/api/fcm/list")
    let header: HTTPHeaders = [
        "Authorization" : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjb25jZXJ0cmlwIiwidXNlcklkeCI6Mn0.Hc9kqk1lE4H1gMXxsTLt50GTP2wpPPv_x4TzuTMM2o8"
    ]
    
    func getAlarmList(completion: @escaping ([Alarm]) -> Void) {
        gettable(alarmURL, body: nil, header: header) { (res) in
            switch res {
            case .success(let value):
                guard let alarmList = value.data else
                {return}
                completion(alarmList)
            case .error(let error):
                print(error)
            }
        }
    }
}
