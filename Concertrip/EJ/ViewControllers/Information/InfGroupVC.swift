//
//  InfGroupVC.swift
//  Concertrip
//
//  Created by 양어진 on 29/12/2018.
//  Copyright © 2018 양어진. All rights reserved.
//

import UIKit
import YouTubePlayer_Swift
import Toast_Swift

class InfGroupVC: UIViewController {
    
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var youtubeView: YouTubePlayerView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var bigProfileImg: UIImageView!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var isLikeBtnActivated = false
    var detailId : String?
    var eventList = [EventList]()
    var memberList = [MemberList]()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bigProfileImg.circleImageView()
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        DetailArtistService.shared.getArtistDetailList(id: detailId!){
            [weak self] (data) in
            guard let `self` = self else { return }
            let detailData = data as DetailArtist
            print("detailData : ", detailData)
            guard let events = detailData.dEventsList else { return }
            print("이벤트 : ", events)
            self.eventList = events
            guard let members = detailData.dMemberList else { return }
            print("멤버 : ", members)
            self.memberList = members
            
            let backImg = detailData.dArtistBackImg
            let profileImg = detailData.dArtistProfileImg
            let likeCount = String(detailData.dArtistSubscribeNum!)
            let youtubeURL = detailData.dYoutubeUrl
            self.backgroundImg.imageFromUrl(backImg, defaultImgPath: "likeicon")
            self.bigProfileImg.imageFromUrl(profileImg, defaultImgPath: "likeicon")
            self.nameLabel.text = detailData.dArtistName
            self.likeCountLabel.text = likeCount
            self.youtubeView.loadVideoID(youtubeURL!)
            

            self.tableView.reloadData()
            self.collectionView.reloadData()
        }
        
    }
    
    @IBAction func likeBtnAction(_ sender: Any) {
        
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

extension InfGroupVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("이벤트 개수 : ", eventList.count)
        return eventList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("안에 들어왔다!!")
        let event = eventList[indexPath.row]
        print("안에 들어온 event : ", event)
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfGroupTVCell") as! InfGroupTVCell
        print("안에 들어왔나요 ?? ", event)
        
        cell.concertNameLabel.text = event.eventName
        cell.concertProfileImg.imageFromUrl(gsno(event.eventProfileImg), defaultImgPath: "likeicon")
        return cell
    }
}

extension InfGroupVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("멤버수 : ", memberList.count)
        return memberList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfGroupCVCell", for: indexPath) as! InfGroupCVCell
        let member = memberList[indexPath.row]
        cell.memberImg.imageFromUrl(gsno(member.memProfileImg), defaultImgPath: "")
        cell.memberImg.circleImageView()
        cell.memberNameLabel.text = member.memName
        
        return cell
    }
}
