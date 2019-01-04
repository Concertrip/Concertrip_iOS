//
//  LikeTVCell.swift
//  Concertrip
//
//  Created by 양어진 on 29/12/2018.
//  Copyright © 2018 양어진. All rights reserved.
//

import UIKit

class LikeTVCell: UITableViewCell {
    
    var subscribeHandler : ((_ contentId : String) -> Void)?
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hashLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    var contentId : String = ""
    
    func configure(data : Subscribe) {
        contentId = data.id!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImg.layer.masksToBounds = false
        profileImg.layer.borderColor = UIColor.black.cgColor
        profileImg.layer.cornerRadius = profileImg.frame.height/2
        profileImg.clipsToBounds = true
        
        likeBtn.addTarget(self, action: #selector(subscribeFunc), for: .touchUpInside)
    }
    
    @objc func subscribeFunc(_ sender: UIButton){
        subscribeHandler!(contentId)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
