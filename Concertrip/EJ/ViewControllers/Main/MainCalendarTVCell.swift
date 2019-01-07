//
//  MainCalendarTVCell.swift
//  Concertrip
//
//  Created by 양어진 on 23/12/2018.
//  Copyright © 2018 양어진. All rights reserved.
//

import UIKit

class MainCalendarTVCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hashLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var profileImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImg.circleImageView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
