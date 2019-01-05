//
//  InfThemeTVCell.swift
//  Concertrip
//
//  Created by 양어진 on 05/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import UIKit

class InfThemeTVCell: UITableViewCell {
    
    @IBOutlet weak var themeProfileImg: UIImageView!
    @IBOutlet weak var themeNameLabel: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        themeProfileImg.circleImageView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
