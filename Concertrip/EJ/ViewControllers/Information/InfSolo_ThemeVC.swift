//
//  InfSolo+ThemeVC.swift
//  Concertrip
//
//  Created by 양어진 on 29/12/2018.
//  Copyright © 2018 양어진. All rights reserved.
//

import UIKit
import YouTubePlayer_Swift
import Toast_Swift

class InfSolo_ThemeVC: UIViewController {
    
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var youtubeView: YouTubePlayerView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var bigProfileImg: UIImageView!
    @IBOutlet weak var likeBtn: UIButton!
    var isLikeBtnActivated = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        youtubeView.loadVideoID("nM0xDI5R50E")
        
        tableView.dataSource = self
        tableView.delegate = self
        
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
    
    @IBAction func backBtnAction(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
    }
    
}


extension InfSolo_ThemeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "InfSoloThemeTVCell") as! InfSoloThemeTVCell


        cell.concertHashLabel.text = "아료앟세용"

        return cell
    }


}
