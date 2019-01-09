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
    var detailId : String?
    var eventList = [EventList]()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bigProfileImg.circleImageView()
        tableView.dataSource = self
        tableView.delegate = self
        
        print("detailId : \(gsno(detailId))")
        
        
        DetailArtistService.shared.getArtistDetailList(id: detailId!) { [weak self] (data) in
            guard let `self` = self else { return }
            
            let detailData = data as DetailArtist
            guard let events = detailData.dEventsList else { return }
            self.eventList = events
            
            
            let backImg = detailData.dArtistBackImg
            let profileImg = detailData.dArtistProfileImg
            let likeCount = String(detailData.dArtistSubscribeNum!)
            let youtubeURL = detailData.dYoutubeUrl
            self.backgroundImg.imageFromUrl(backImg, defaultImgPath: "")
            self.bigProfileImg.imageFromUrl(profileImg, defaultImgPath: "")
            self.nameLabel.text = detailData.dArtistName
            self.likeCountLabel.text = likeCount
            self.youtubeView.loadVideoID(youtubeURL!)
            
            //dSubscribe
            if detailData.dSubscribe! == true {
                self.likeBtn.imageView?.image = UIImage(named : "infoLikeButtonActivated")
                self.isLikeBtnActivated = true
            }
            else {
                self.likeBtn.imageView?.image = UIImage(named: "infoLikeButton")
                self.isLikeBtnActivated = false
            }
            self.tableView.reloadData()
            

        }
        
        
    }
    
    @IBAction func likeBtnAction(_ sender: Any) {
        SubscribeArtistService.shared.subscriptArtist(id: detailId!) {
            if self.isLikeBtnActivated == false {
                self.likeBtn.imageView?.image = UIImage(named : "infoLikeButton")
                self.isLikeBtnActivated = true
                self.view.makeToast("내 공연에 추가되었습니다!")
            }
            else {
                self.likeBtn.imageView?.image = UIImage(named: "infoLikeButtonActivated")
                self.isLikeBtnActivated = false
            }
        }
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}


extension InfSolo_ThemeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("eventList.count : \(eventList.count)")
        return eventList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "InfSoloThemeTVCell") as! InfSoloThemeTVCell
        
        var event = eventList[indexPath.row]
        
        cell.concertNameLabel.text = event.eventName
        cell.concertProfileImg.imageFromUrl(gsno(event.eventProfileImg), defaultImgPath: "")
        
        if event.eventSubscribe! == false {
            print(cell.addBtn.imageView?.image)
            cell.addBtn.setImage(UIImage(named: "concertLikeButton"), for: .normal)
        }
        else {
            cell.addBtn.setImage(UIImage(named: "concertLikeButtonActivated"), for: .normal)
        }
        
        cell.configure(data: event)
        cell.subscribeHandler = {(concertId) in
            SubscribeEventService.shared.subscriptEvent(id: concertId){
                if event.eventSubscribe == false {
                    cell.addBtn.setImage(UIImage(named: "concertLikeButtonActivated"), for: .normal)
                    //                    cell.addBtn.imageView?.image =  UIImage(named: "concertLikeButtonActivated")
                    event.eventSubscribe = true
                    self.view.makeToast("내 공연에 추가되었습니다!")
                } else {
                    cell.addBtn.setImage(UIImage(named: "concertLikeButton"), for: .normal)
                    //                    cell.addBtn.imageView?.image =  UIImage(named: "concertLikeButton")
                    event.eventSubscribe = false
                }
            }
        }
        
        
        return cell
    }


}
