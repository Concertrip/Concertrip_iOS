//
//  DetailService.swift
//  Concertrip
//
//  Created by 양어진 on 05/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import Foundation
import Alamofire

struct DetailService: APIManager, Requestable{
    typealias NetworkData = ResponseObject<DetailArtist>
    static let shared = DetailService()
    var detailURL = url("/api/artist/detail")
    let header: HTTPHeaders = [
        "Content-Type" : "application/json",
        "Authorization" : "1"
    ]
    
    
    func getArtistDetailList(id: String, completion: @escaping (DetailArtist) -> Void) {
        let artistDetail = detailURL + "?id=\(id)"
        gettable(artistDetail, body: nil, header: header) { (res) in
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
