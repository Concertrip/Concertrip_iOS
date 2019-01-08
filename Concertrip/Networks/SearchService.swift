//
//  SearchService.swift
//  Concertrip
//
//  Created by 심지원 on 2019. 1. 1..
//  Copyright © 2019년 양어진. All rights reserved.
//

import Foundation
import Alamofire

struct SearchService: APIManager, Requestable{
    typealias NetworkData = ResponseObject<SearchObject>
    static let shared = SearchService()
    var searchURL = url("/api/search")
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
        "Authorization" : "2"
    ]
    
    

    func getSearchResult(tag: String, completion: @escaping (SearchObject) -> Void) {
        let queryURL = searchURL + "?tag=\(tag)"
        guard let searchURL = queryURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        gettable(searchURL, body: nil, header: header) {
            (res) in
            switch res{
            case .success(let value):
                guard let searchData = value.data else{return}
                completion(searchData)
            case .error(let error):
                print("에러에러 : \(error)")
            }
        }
    }
}
