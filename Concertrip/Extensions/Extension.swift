//
//  Extension.swift
//  Concertrip
//
//  Created by 양어진 on 26/12/2018.
//  Copyright © 2018 양어진. All rights reserved.
//

import Foundation
import CVCalendar

extension CVDate {
    public var koreanDescription: String {
        return "\(month)월"
    }
//    public var commonDescription: String {
//        let month = dateFormattedStringWithFormat("MMMM", fromDate: date)
//        return "\(day) \(month), \(year)"
//    }
}
