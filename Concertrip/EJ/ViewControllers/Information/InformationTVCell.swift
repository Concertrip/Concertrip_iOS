//
//  InformationTVCell.swift
//  Concertrip
//
//  Created by 양어진 on 27/12/2018.
//  Copyright © 2018 양어진. All rights reserved.
//

import UIKit

class InformationTVCell: UITableViewCell {

    @IBOutlet weak var concertProfileImg: UIImageView!
    @IBOutlet weak var concertNameLabel: UILabel!
    @IBOutlet weak var concertHashtagLabel: UILabel!
    
    @IBAction func concertLikeBtnAction(_ sender: Any) {
        
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
