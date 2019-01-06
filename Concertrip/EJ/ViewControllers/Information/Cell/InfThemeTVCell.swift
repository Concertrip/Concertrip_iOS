//
//  InfThemeTVCell.swift
//  Concertrip
//
//  Created by 양어진 on 05/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import UIKit

class InfThemeTVCell: UITableViewCell {
    var subscribeHandler : ((_ concertId : String) -> Void)?
    
    @IBOutlet weak var themeProfileImg: UIImageView!
    @IBOutlet weak var themeNameLabel: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    var concertId : String = ""
    
    func configure(data : EventList) {
        concertId = data.eventId!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addBtn.addTarget(self, action: #selector(subscribe), for: .touchUpInside)
        themeProfileImg.circleImageView()
    }
    
    @objc func subscribe(_ sender : UIButton){
        subscribeHandler!(concertId)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
