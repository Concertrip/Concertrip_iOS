//
//  InfConcert_2VC.swift
//  Concertrip
//
//  Created by 양어진 on 09/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import UIKit
import YouTubePlayer_Swift
import Toast_Swift


class InfConcert_2VC: UIViewController {
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var youtubeView: YouTubePlayerView!
    @IBOutlet weak var performerCollectionView: UICollectionView!
    @IBOutlet weak var cautionCollectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var concertDateLabel: UILabel!
    @IBOutlet weak var concertLocationLabel: UILabel!
    @IBOutlet weak var concertPriceLabel: UILabel!
    @IBOutlet weak var infoImg: UIImageView!
    @IBOutlet weak var bigProfileImg: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var isLikeBtnActivated = false
    var detailId : String?
    var memberList = [MemberList]()
    var seatNameList:[String] = []
    var seatPriceList:[String] = []
    var namePriceList:[String] = []
    var dateTxt  = ""
    var priceTxt = ""
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.addSubview(infoImg)
        scrollView.contentSize = infoImg.bounds.size
        
        print("detailId : \(gsno(detailId))")
        bigProfileImg.circleImageView()
        DetailEventService.shared.getConcertDetailList(id: detailId!) { [weak self] (data) in
            guard let `self` = self else { return }
            let detailData = data as DetailConcert
            guard let members = detailData.dConcertMemberList else { return }
            self.memberList = members

            print("memberList : \(self.memberList)")

            self.concertLocationLabel.text = detailData.dConcertLocation
            self.bigProfileImg.imageFromUrl(detailData.dConcertProfileImg, defaultImgPath: "")
            self.backgroundImg.imageFromUrl(detailData.dConcertBackImg, defaultImgPath: "")
            self.likeCountLabel.text = String(detailData.dConcertSubscribeNum!)
            let youtubeURL = detailData.dConcertYoutubeUrl
            self.youtubeView.loadVideoID(youtubeURL!)
            self.nameLabel.text = detailData.dConcertName
            self.infoImg.imageFromUrl(detailData.dConcertEventInfoImg, defaultImgPath: "")

            for data in detailData.dConcertSeatName! {
                print("seatname : \(data)")
                self.seatNameList.append(data)
            }
            for data in detailData.dConcertSeatPrice! {
                print("price : \(data)")
                self.seatPriceList.append(data)
            }

            self.infoImg.imageFromUrl(detailData.dConcertEventInfoImg, defaultImgPath: "")
            
            for data in detailData.dConcertDate! {
                self.dateTxt += data + "\n"
                
            }
            
            for i in 0 ..< self.seatNameList.count {
                self.priceTxt += "■ " +  self.seatNameList[i] + " : " + self.seatPriceList[i] + "\n"
            }
            
            print("dateTxt : \(self.dateTxt)")
            self.concertDateLabel.text = self.dateTxt
            self.concertPriceLabel.text = self.priceTxt

            self.performerCollectionView.reloadData()
        }

        performerCollectionView.delegate = self
        performerCollectionView.dataSource = self
        //        cautionCollectionView.delegate = self
        //        cautionCollectionView.dataSource = self

    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func likeBtnAction(_ sender: Any) {
    }
    @IBAction func reservationBtnAction(_ sender: Any) {
    }
    

}
extension InfConcert_2VC : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("memberList.count : \(memberList.count)")
        return memberList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfConcertPerformerCVCell", for: indexPath) as! InfConcertPerformerCVCell
        let member = memberList[indexPath.row]
        
        cell.profileImg.imageFromUrl(gsno(member.memProfileImg), defaultImgPath: "likebtn")
        cell.nameLabel.text = member.memName
        
        
        return cell
    }
}
