//
//  DetailEventService.swift
//  Concertrip
//
//  Created by 양어진 on 06/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import Foundation
import Alamofire

struct DetailEventService: APIManager, Requestable{
    typealias NetworkData = ResponseObject<DetailConcert>
    static let shared = DetailEventService()
    var detailURL = url("/api/event/detail")
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
        "Authorization" : "2"
    ]
    
    
    func getConcertDetailList(id: String, completion: @escaping (DetailConcert) -> Void) {
        let concertURL = detailURL + "?id=\(id)"
        print("id : \(id)")
        gettable(concertURL, body: nil, header: header) { (res) in
            print("gettable안쪽입니다.")
            switch res {
            case .success(let value):
                guard let detailList = value.data else
                {   print("res : \(res)")
                    return}
                print("hello~?")
                completion(detailList)
            case .error(let error):
                print("에러러러 : \(error)")
            }
        }
    }
    
    
}
