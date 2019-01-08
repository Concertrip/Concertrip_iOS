//
//  InfGroupTVCell.swift
//  Concertrip
//
//  Created by 양어진 on 01/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import UIKit

class InfGroupTVCell: UITableViewCell {
    var subscribeHandler : ((_ concertId : String) -> Void)?
    
    @IBOutlet weak var concertProfileImg: UIImageView!
    @IBOutlet weak var concertHashLabel: UILabel!
    @IBOutlet weak var concertNameLabel: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    var concertId : String = ""
    
    func configure(data : EventList){
        concertId = data.eventId!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addBtn.addTarget(self, action: #selector(subscribe), for: .touchUpInside)
        concertProfileImg.circleImageView()
    }
    
    @objc func subscribe(_ sender : UIButton){
        subscribeHandler!(concertId)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
