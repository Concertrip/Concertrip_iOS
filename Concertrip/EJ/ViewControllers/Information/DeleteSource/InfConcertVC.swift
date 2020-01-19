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
    var detailId : String?
    var memberList = [MemberList]()
    var seatNameList:[String] = []
    var seatPriceList:[String] = []
    
    var dateTxt  = ""
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bigProfileImg.circleImageView()
        DetailEventService.shared.getConcertDetailList(id: detailId!) { [weak self] (data) in
            guard let `self` = self else { return }
            let detailData = data as DetailConcert
            guard let members = detailData.dConcertMemberList else { return }
            self.memberList = members
            
            for data in detailData.dConcertDate! {
                self.dateTxt += data + "\n"
            }
            
            self.concertDateLabel.text = self.dateTxt
            self.concertLocationLabel.text = detailData.dConcertLocation
            self.bigProfileImg.imageFromUrl(detailData.dConcertProfileImg, defaultImgPath: "")
            self.backgroundImg.imageFromUrl(detailData.dConcertBackImg, defaultImgPath: "")
            self.likeCountLabel.text = String(detailData.dConcertSubscribeNum!)
            let youtubeURL = detailData.dConcertYoutubeUrl
            self.youtubeView.loadVideoID(youtubeURL!)
            self.nameLabel.text = detailData.dConcertName
            self.performImg.imageFromUrl(detailData.dConcertEventInfoImg, defaultImgPath: "")
            
            for data in detailData.dConcertSeatName! {
                self.seatNameList.append(data)
            }
            for data in detailData.dConcertSeatPrice! {
                self.seatPriceList.append(data)
            }
            
            if detailData.dConcertSubscribe! == true {
                self.likeBtn.imageView?.image = UIImage(named: "infoLikeButtonActivated")
                self.isLikeBtnActivated = true
            }
            else {
                self.likeBtn.imageView?.image = UIImage(named: "infoLikeButton")
                self.isLikeBtnActivated = false
            }
            self.performImg.imageFromUrl(detailData.dConcertEventInfoImg, defaultImgPath: "")
            
            self.performerCollectionView.reloadData()
            self.tableView.reloadData()
        }
        
        performerCollectionView.delegate = self
        performerCollectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func likeBtnAction(_ sender: Any) {
        SubscribeEventService.shared.subscriptEvent(id: detailId!) {
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

extension InfConcertVC : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memberList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfPerformerCVCell", for: indexPath) as! InfPerformerCVCell
        let member = memberList[indexPath.row]
        
        cell.performerImg.imageFromUrl(gsno(member.memProfileImg), defaultImgPath: "likebtn")
        cell.performerNameLabel.text = member.memName
        
        return cell
    }
}


extension InfConcertVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seatPriceList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfTicketPriceTVCell") as! InfTicketPriceTVCell
        
        let price = seatPriceList[indexPath.row]
        let name = seatNameList[indexPath.row]
        
        cell.ticketNamePriceLabel.text = name + " " + price
        
        return cell
    }


}

