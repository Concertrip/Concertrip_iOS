//
//  ExploreTVCell.swift
//  Concertrip
//
//  Created by 심지원 on 2018. 12. 25..
//  Copyright © 2018년 양어진. All rights reserved.
//

import UIKit

class ExploreTVCell: UITableViewCell {
    var subscribeHandler : ((_ albumId : String) -> Void)?

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hashtagLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    var artistId : String = ""
    var themeId : String = ""
    
    func configureArtist(data : Artists){
        artistId = data.artistId!
    }
    func configureTheme(data : TabTheme){
        themeId = data.themeId!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImg.circleImageView()
        likeBtn.addTarget(self, action: #selector(subscribe), for: .touchUpInside)

    }
    @objc func subscribe(_ sender : UIButton){
        subscribeHandler!(artistId)
        subscribeHandler!(themeId)
    }

}
