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
    @IBOutlet weak var gradientView: UIView!
    
    var isLikeBtnActivated = false
    var detailId : String?
    var eventList = [EventList]()
    var memberList = [MemberList]()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    //그라데이션 배경
    func getGradientBackground(){
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.frame.size = self.view.frame.size
        gradientLayer.colors = [UIColor(cgColor: #colorLiteral(red: 0.05882352941, green: 0.06274509804, blue: 0.09019607843, alpha: 1)).cgColor,UIColor(cgColor: #colorLiteral(red: 0, green: 0.01176470588, blue: 0.1607843137, alpha: 1)).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        self.gradientView.layer.addSublayer(gradientLayer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGradientBackground()
        bigProfileImg.circleImageView()
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        getGroupList()
        
    }
    
    func getGroupList(){
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
            
            if detailData.dSubscribe == true {
                self.likeBtn.imageView?.image = UIImage(named: "infoLikeButtonActivated")
                self.isLikeBtnActivated = true
            }
            else {
                self.likeBtn.imageView?.image = UIImage(named: "infoLikeButton")
                self.isLikeBtnActivated = false
            }
            
            self.tableView.reloadData()
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func likeBtnAction(_ sender: Any) {
        SubscribeArtistService.shared.subscriptArtist(id: detailId!) {
            if self.isLikeBtnActivated == false {
                self.likeBtn.imageView?.image =  UIImage(named: "infoLikeButtonActivated")
                self.isLikeBtnActivated = true
                self.view.makeToast("내 공연에 추가되었습니다!")
                self.getGroupList()
            } else {
                self.likeBtn.imageView?.image =  UIImage(named: "infoLikeButton")
                self.getGroupList()
                self.view.makeToast("내 공연에서 삭제되었습니다!")
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
        var event = eventList[indexPath.row]
        print("안에 들어온 event : ", event)
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfGroupTVCell") as! InfGroupTVCell
        print("안에 들어왔나요 ?? ", event)
        cell.selectionStyle = .none

        cell.concertNameLabel.text = event.eventName
        cell.concertProfileImg.imageFromUrl(gsno(event.eventProfileImg), defaultImgPath: "likeicon")
        
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
                    event.eventSubscribe = true
                    self.view.makeToast("내 공연에 추가되었습니다!")
                } else {
                    cell.addBtn.setImage(UIImage(named: "concertLikeButton"), for: .normal)
                    event.eventSubscribe = false
                }
            }
        }
        
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

extension InfGroupVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
