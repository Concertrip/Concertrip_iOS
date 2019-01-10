//
//  Payment.swift
//  Concertrip
//
//  Created by 양어진 on 10/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import Foundation
import UIKit

struct Payment {
    var paymentImg: UIImage?
    var paymentTitle: String
    
    init(title: String, imgName: String) {
        self.paymentImg = UIImage(named: imgName)
        self.paymentTitle = title
    }
}
