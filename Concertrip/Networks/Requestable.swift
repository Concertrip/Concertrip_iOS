//
//  Requestable.swift
//  Concertrip
//
//  Created by 심지원 on 2018. 12. 27..
//  Copyright © 2018년 양어진. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

protocol Requestable {
    associatedtype NetworkData: Mappable
}

//Request 함수를 재사용하기 위한 프로토콜입니다.
//postable은 이미 작성되어 있습니다.
//gettable을 직접 구현해보세요!

extension Requestable {
    
    //서버에 get 요청을 보내는 함수
    func gettable(_ url: String, body: [String:Any]?, header: HTTPHeaders?, completion: @escaping (NetworkResult<NetworkData>) -> Void) {
        //코드 작성
    }
    
    //서버에 post 요청을 보내는 함수
    func postable(_ url: String, body: [String:Any]?, header: HTTPHeaders?, completion: @escaping (NetworkResult<NetworkData>) -> Void) {
        Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseObject { (res: DataResponse<NetworkData>) in
//            switch res.response?.statusCode {
//            
//            }
            switch res.result {
            case .success:
                guard let value = res.result.value else { return }
                completion(.success(value))
            case .failure(let err):
                completion(.error(err))
            }
        }
    }
}
