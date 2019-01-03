//
//  ExploreClickedVCCell.swift
//  Concertrip
//
//  Created by 심지원 on 2018. 12. 26..
//  Copyright © 2018년 양어진. All rights reserved.
//

import UIKit

class ExploreClickedVCCell: UITableViewCell {
    var obj : (() -> Void)? = nil
    var subscribeHandler : ((_ albumId : String) -> Void)?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var hashtagLabel: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    var albumId : String = ""
    
    func configure(data : Artists) {
        albumId = data.artistId!
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        likeBtn.addTarget(self, action: #selector(subscribe), for: .touchUpInside)
    }

    @objc func subscribe(_ sender : UIButton){
       subscribeHandler!(albumId)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
