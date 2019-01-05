//
//  ExploreTVCell.swift
//  Concertrip
//
//  Created by 심지원 on 2018. 12. 25..
//  Copyright © 2018년 양어진. All rights reserved.
//

import UIKit

class ExploreTVCell: UITableViewCell {
    var subscribeHandler : ((_ artistId : String) -> Void)?

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hashtagLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    var artistId : String = ""
    
    func configureArtist(data : Artists){
        artistId = data.artistId!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImg.layer.cornerRadius = 15
        profileImg.layer.masksToBounds = true
        likeBtn.addTarget(self, action: #selector(subscribe), for: .touchUpInside)

    }
    @objc func subscribe(_ sender : UIButton){
        subscribeHandler!(artistId)
    }

}
