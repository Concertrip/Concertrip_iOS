//
//  NotificationService.swift
//  Concertrip
//
//  Created by 심지원 on 2019. 1. 12..
//  Copyright © 2019년 양어진. All rights reserved.
//

import Foundation
import Alamofire

struct NotificationService: APIManager, Requestable{
    typealias NetworkData = Notifications
    static let shared = NotificationService()
    var searchURL = url("/api/fcm/list")
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
        "Authorization" : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjb25jZXJ0cmlwIiwidXNlcklkeCI6MX0.qDnh3VXMVAoKzWqeXzDwH9heZoRbL1AO6dy2FgieviI"
    ]
    
    func getNotification(completion: @escaping ([Notifications]) -> Void) {
        gettable(searchURL, body: nil, header: header) {
            (res) in
            switch res{
            case .success(let value):
                completion([value])
            case .error(let error):
                print("에러에러 : \(error)")
            }
        }
    }
}
