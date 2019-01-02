//
//  InfConcertVC.swift
//  Concertrip
//
//  Created by 양어진 on 29/12/2018.
//  Copyright © 2018 양어진. All rights reserved.
//

import UIKit
import YouTubePlayer_Swift
import Toast_Swift

class InfConcertVC: UIViewController {
    
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var youtubeView: YouTubePlayerView!
    @IBOutlet weak var performerCollectionView: UICollectionView!
    @IBOutlet weak var performImg: UIImageView!
    @IBOutlet weak var cautionCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var bigProfileImg: UIImageView!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var concertDateLabel: UILabel!
    @IBOutlet weak var concertLocationLabel: UILabel!
    
    var isLikeBtnActivated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func likeBtnAction(_ sender: Any) {
        if isLikeBtnActivated == false {
            simpleOnlyOKAlertwithHandler(title: "캘린더에 추가되었습니다!", message: "") { (okAction) in
                self.likeBtn.imageView?.image =  UIImage(named: "artistLikeButtonActivated")
//                self.view.makeToast("토스트 메세지입니다.")
                self.isLikeBtnActivated = true
            }
        } else {
            simpleOnlyOKAlertwithHandler(title: "캘린더에서 삭제되었습니다!", message: "") { (okAction) in
                self.likeBtn.imageView?.image =  UIImage(named: "artistLikeButton")
                self.isLikeBtnActivated = false
            }
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
