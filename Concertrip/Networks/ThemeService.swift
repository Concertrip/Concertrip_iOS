//
//  ThemeService.swift
//  Concertrip
//
//  Created by 심지원 on 2019. 1. 10..
//  Copyright © 2019년 양어진. All rights reserved.
//

import Foundation
import Alamofire

struct ThemeService : APIManager, Requestable{
    typealias NetworkData = ResponseArray<TabTheme>
    static let shared = ThemeService()
    var detailURL = url("/api/search/tab")
    let header: HTTPHeaders = [
        "Authorization" : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjb25jZXJ0cmlwIiwidXNlcklkeCI6Mn0.Hc9kqk1lE4H1gMXxsTLt50GTP2wpPPv_x4TzuTMM2o8"
    ]
    
    func getThemeList(name: String, completion: @escaping ([TabTheme]) -> Void) {
        
        let themeURL = detailURL + "?name=\(name)"
        guard let searchURL = themeURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        gettable(searchURL, body: nil, header: header) { (res) in
            print("결과는? : ", res)
            switch res {
            case .success(let value):
                guard let tabTheme = value.data else
                {return}
                completion(tabTheme)
            case .error(let error):
                print(error)
            }
        }
    }
}
