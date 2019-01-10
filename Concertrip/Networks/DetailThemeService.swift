//
//  DetailThemeService.swift
//  Concertrip
//
//  Created by 양어진 on 05/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import Foundation
import Alamofire

struct DetailThemeService: APIManager, Requestable{
    typealias NetworkData = ResponseObject<DetailTheme>
    static let shared = DetailThemeService()
    var detailURL = url("/api/genre/detail")
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
        "Authorization" : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjb25jZXJ0cmlwIiwidXNlcklkeCI6Mn0.Hc9kqk1lE4H1gMXxsTLt50GTP2wpPPv_x4TzuTMM2o8"
    ]
    
    
    func getThemeDetailList(id: String, completion: @escaping (DetailTheme) -> Void) {
        let themeDetail = detailURL + "?id=\(id)"
        gettable(themeDetail, body: nil, header: header) { (res) in
            switch res {
            case .success(let value):
                guard let detailList = value.data else
                {return}
                completion(detailList)
            case .error(let error):
                print(error)
            }
        }
    }
    
    
}
