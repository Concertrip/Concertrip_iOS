//
//  SubscribeEventService.swift
//  Concertrip
//
//  Created by 심지원 on 2019. 1. 2..
//  Copyright © 2019년 양어진. All rights reserved.
//

import Foundation
import Alamofire

struct SubscribeEventService: APIManager, Requestable{
    typealias NetworkData = ResponseObject<Token>
    static let shared = SubscribeEventService()
    var subscribeURL = url("/api/subscribe/event")
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
        "Authorization" : "2"
    ]
    
    func subscriptEvent(id: String, completion: @escaping () -> Void) {
        let body = [
            "id" : id
        ]
        postable(subscribeURL, body: body, header: header) { res in
            switch res {
            case .success( _):
                completion()
            case .error(let error):
                print(error)
            }
        }
        
    }
    
}
