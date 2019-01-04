//
//  SubscribeGenreService.swift
//  Concertrip
//
//  Created by 심지원 on 2019. 1. 2..
//  Copyright © 2019년 양어진. All rights reserved.
//

import Foundation
import Alamofire

struct SubscribeGenreService: APIManager, Requestable{
    typealias NetworkData = ResponseObject<Token>
    static let shared = SubscribeGenreService()
    var subscribeURL = url("/api/subscribe/genre")
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
        "Authorization" : "1"
    ]
    
    func subscriptGenre(id: String, completion: @escaping () -> Void) {
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
