//
//  InfSoloThemeTVCell.swift
//  Concertrip
//
//  Created by 양어진 on 29/12/2018.
//  Copyright © 2018 양어진. All rights reserved.
//

import UIKit

class InfSoloThemeTVCell: UITableViewCell {
    @IBOutlet weak var concertProfileImg: UIImageView!
    @IBOutlet weak var concertHashLabel: UILabel!
    @IBOutlet weak var concertNameLabel: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        concertProfileImg.circleImageView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
