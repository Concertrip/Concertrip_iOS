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
    var genreId : String = ""
    var eventId : String = ""
    
    func configureZero(data : Artists) {
        albumId = data.artistId!
    }
    func configureOne(data : Genres){
        genreId = data.genreId!
    }
    func configureTwo(data : Events){
        eventId = data.eventId!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeBtn.addTarget(self, action: #selector(subscribe), for: .touchUpInside)
    }

    @objc func subscribe(_ sender : UIButton){
        subscribeHandler!(albumId)
        subscribeHandler!(genreId)
        subscribeHandler!(eventId)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
