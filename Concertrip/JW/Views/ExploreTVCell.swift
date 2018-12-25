//
//  ExploreTVCell.swift
//  Concertrip
//
//  Created by 심지원 on 2018. 12. 25..
//  Copyright © 2018년 양어진. All rights reserved.
//

import UIKit

class ExploreTVCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hashtagLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImg.layer.cornerRadius = 15
        profileImg.layer.masksToBounds = true 
    }

}
