//
//  InfConcertPerformerCVCell.swift
//  Concertrip
//
//  Created by 양어진 on 09/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import UIKit

class InfConcertPerformerCVCell: UICollectionViewCell {
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        profileImg.circleImageView()
    }
}
