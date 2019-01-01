//
//  TicketService.swift
//  Concertrip
//
//  Created by 양어진 on 01/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import Alamofire

struct TicketService: APIManager, Requestable {
    typealias NetworkData = ResponseArray<Ticket>
    static let shared = TicketService()
    let queryURL = url("/api/ticket")
    let header: HTTPHeaders = [
        "Content-Type": "application/json",
        "Authorization": "1"
    ]
    
    func getTicketList(completion: @escaping ([Ticket]) -> Void) {
        gettable(queryURL, body: nil, header: header) { (res) in
            switch res {
            case .success(let value):
                guard let ticketList = value.data else
                {return}
                completion(ticketList)
            case .error(let error):
                print(error)
            }
        }
    }
    
//    //게시글 상세 조회 api
//    func getBoardDetail(id: Int, completion: @escaping ([Board]) -> Void) {
//        //코드 작성
//        let queryURL = boardURL + "/\(id)"
//        gettable(queryURL, body: nil, header: header) { (res) in
//            switch res {
//            case .success(let value):
//                guard let boardList = value.data else
//                {return}
//                completion(boardList)
//            case .error(let error):
//                print(error)
//            }
//        }
//    }
    
   
}
