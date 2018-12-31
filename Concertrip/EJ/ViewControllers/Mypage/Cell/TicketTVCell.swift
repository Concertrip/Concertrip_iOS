//
//  TicketTVCell.swift
//  Concertrip
//
//  Created by 양어진 on 31/12/2018.
//  Copyright © 2018 양어진. All rights reserved.
//

import UIKit

class TicketTVCell: UITableViewCell {

    @IBOutlet weak var concertNameLabel: UILabel!
    @IBOutlet weak var concertDateLabel: UILabel!
    @IBOutlet weak var concertLocationLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
