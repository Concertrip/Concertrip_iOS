//
//  SubscribeService.swift
//  Concertrip
//
//  Created by 양어진 on 02/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import Foundation
import Alamofire

struct SubscribeService: APIManager, Requestable{
    typealias NetworkData = ResponseArray<Subscribe>
    static let shared = SubscribeService()
    var subscribeURL = url("/api/subscribe")
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
        "Authorization" : "1"
    ]
    
    
    func getArtistList(completion: @escaping ([Subscribe]) -> Void) {
        let subArtistURL = subscribeURL + "/artist"
        gettable(subArtistURL, body: nil, header: header) { (res) in
            switch res {
            case .success(let value):
                guard let artistList = value.data else
                {return}
                completion(artistList)
            case .error(let error):
                print(error)
            }
        }
    }
    
    func getEventList(completion: @escaping ([Subscribe]) -> Void) {
        let subEventURL = subscribeURL + "/event"
        gettable(subEventURL, body: nil, header: header) { (res) in
            switch res {
            case .success(let value):
                guard let eventList = value.data else
                {return}
                completion(eventList)
            case .error(let error):
                print(error)
            }
        }
    }
    
    func getThemeList(completion: @escaping ([Subscribe]) -> Void) {
        let subThemeURL = subscribeURL + "/genre"
        gettable(subThemeURL, body: nil, header: header) { (res) in
            switch res {
            case .success(let value):
                guard let themeList = value.data else
                {return}
                completion(themeList)
            case .error(let error):
                print(error)
            }
        }
    }
}
