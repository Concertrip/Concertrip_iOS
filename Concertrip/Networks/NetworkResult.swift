//
//  NetworkResult.swift
//  Concertrip
//
//  Created by 심지원 on 2018. 12. 27..
//  Copyright © 2018년 양어진. All rights reserved.
//

enum NetworkResult<T> {
    case success(T)
    case error(Error)
}
