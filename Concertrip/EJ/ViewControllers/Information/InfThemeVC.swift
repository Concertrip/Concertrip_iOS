//
//  InfThemeVC.swift
//  Concertrip
//
//  Created by 양어진 on 05/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import UIKit
import YouTubePlayer_Swift

class InfThemeVC: UIViewController {

    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var youtubeView: YouTubePlayerView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var bigProfileImg: UIImageView!
    @IBOutlet weak var likeBtn: UIButton!
    
    var isLikeBtnActivated = false
    var detailId : String?
    var eventList = [EventList]()
//    var eventComing = [Events]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bigProfileImg.circleImageView()
        tableView.delegate = self
        tableView.dataSource = self
        
        print("theme detailId : \(gsno(detailId))")
        
        DetailThemeService.shared.getThemeDetailList(id: detailId!) { [weak self](data) in
            guard let `self` = self else { return }
            let detailData = data as DetailTheme
            guard let events = detailData.dThemeEventList else { return }
            self.eventList = events

            let backImg = detailData.dThemeBackImg
            let profileImg = detailData.dThemeProfileImg
            let likeCount = String(detailData.dThemeSubscribeNum!)
            let youtubeURL = detailData.dThemeYoutubeUrl
            self.backgroundImg.imageFromUrl(backImg, defaultImgPath: "likeicon")
            self.bigProfileImg.imageFromUrl(profileImg, defaultImgPath: "likeicon")
            self.nameLabel.text = detailData.dThemeName
            self.likeCountLabel.text = likeCount
            self.youtubeView.loadVideoID(youtubeURL!)
            
            self.tableView.reloadData()
        }
        
    }
    @IBAction func likeBtn(_ sender: Any) {

        if isLikeBtnActivated == false {
            simpleOnlyOKAlertwithHandler(title: "캘린더에 추가되었습니다!", message: "") { (okAction) in
                self.likeBtn.imageView?.image =  UIImage(named: "infoLikeButtonActivated")
                self.isLikeBtnActivated = true
            }
        } else {
            simpleOnlyOKAlertwithHandler(title: "캘린더에서 삭제되었습니다!", message: "") { (okAction) in
                self.likeBtn.imageView?.image =  UIImage(named: "infoLikeButton")
                self.isLikeBtnActivated = false
            }
        }
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension InfThemeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfThemeTVCell") as! InfThemeTVCell
        var event = eventList[indexPath.row]
        cell.configure(data: event)
        
        cell.subscribeHandler = {(albumId) in
            SubscribeEventService.shared.subscriptEvent(id: albumId){
                print("구독이 됐나요? : ", albumId)
                if self.isLikeBtnActivated == false {
                    self.simpleOnlyOKAlertwithHandler(title: "캘린더에 추가되었습니다!", message: "") { (okAction) in
                        self.likeBtn.imageView?.image =  UIImage(named: "infoLikeButtonActivated")
                        self.isLikeBtnActivated = true
                    }
                } else {
                    self.simpleOnlyOKAlertwithHandler(title: "캘린더에서 삭제되었습니다!", message: "") { (okAction) in
                        self.likeBtn.imageView?.image =  UIImage(named: "infoLikeButton")
                        self.isLikeBtnActivated = false
                    }
                }
            }
        }
        cell.themeProfileImg.imageFromUrl(event.eventProfileImg, defaultImgPath: "")
        cell.themeNameLabel.text = event.eventName
        
        return cell
    }
    
    
}
