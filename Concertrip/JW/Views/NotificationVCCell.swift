//
//  NotificationVCCell.swift
//  Concertrip
//
//  Created by 심지원 on 2018. 12. 24..
//  Copyright © 2018년 양어진. All rights reserved.
//

import UIKit

class NotificationVCCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var titleTxt: UILabel!
    @IBOutlet weak var hashtagTxt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImg.layer.cornerRadius = 3
        profileImg.layer.masksToBounds = true 
    }
}
