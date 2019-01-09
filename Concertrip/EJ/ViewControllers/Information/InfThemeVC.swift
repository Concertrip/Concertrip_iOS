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
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
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
            
            
            print(detailData.dThemeId,"구독 ? : ", detailData.dThemeIsSubscribe!)
            if detailData.dThemeIsSubscribe! == true {
                self.isLikeBtnActivated = true
                self.likeBtn.imageView?.image = UIImage(named : "infoLikeButtonActivated")
            }
            else {
                self.isLikeBtnActivated = false
                self.likeBtn.imageView?.image = UIImage(named: "infoLikeButton")
            }
            //            self.likeBtn.imageFromUrl()
            self.tableView.reloadData()
        }
        
    }
    @IBAction func likeBtn(_ sender: Any) {
        SubscribeGenreService.shared.subscriptGenre(id: detailId!) {
            print("현재 좋아요 상황 : ", self.isLikeBtnActivated)
            if self.isLikeBtnActivated == false {
                self.likeBtn.imageView?.image =  UIImage(named: "infoLikeButtonActivated")
                self.isLikeBtnActivated = true
                self.view.makeToast("내 공연에 추가되었습니다!")

            } else {
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
        cell.selectionStyle = .none
        var event = eventList[indexPath.row]
        
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
        cell.themeProfileImg.imageFromUrl(event.eventProfileImg, defaultImgPath: "")
        cell.themeNameLabel.text = event.eventName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let storyboard = UIStoryboard(name: "InformationSB", bundle: nil)
        let event = eventList[indexPath.row]
        let dvc = storyboard.instantiateViewController(withIdentifier: "InfConcert_2VC") as! InfConcert_2VC
        dvc.detailId = event.eventId
        self.present(dvc, animated: true, completion: nil)
    }
    
}
