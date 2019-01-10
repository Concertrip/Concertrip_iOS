//
//  MainCalendarTVCell.swift
//  Concertrip
//
//  Created by 양어진 on 23/12/2018.
//  Copyright © 2018 양어진. All rights reserved.
//

import UIKit

class MainCalendarTVCell: UITableViewCell {
    var subscribeHandler : ((_ eventId : String) -> Void)?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hashLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var profileImg: UIImageView!
    
    var eventId : String = ""
    
    func configure(data : CalendarList){
        eventId = data.calendarId!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImg.circleImageView()
        likeBtn.addTarget(self, action: #selector(subscribe), for: .touchUpInside)
    }
    
    @objc func subscribe(_ sender : UIButton){
        subscribeHandler!(eventId)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
