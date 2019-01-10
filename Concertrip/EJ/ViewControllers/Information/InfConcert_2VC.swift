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
    @IBOutlet weak var gredientView: UIView!
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
    @IBOutlet weak var gradientView: UIView!
    
    @IBOutlet weak var likeBtn: UIButton!
    
    var isLikeBtnActivated = false
    var detailId : String?
    var memberList = [MemberList]()
    var seatNameList:[String] = []
    var seatPriceList:[String] = []
    var namePriceList:[String] = []
    var dateTxt  = ""
    var priceTxt = ""
    
    @IBAction func backBtnAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func likeBtnAction(_ sender: Any) {
        print("디테일아이디 \(detailId)")
        SubscribeArtistService.shared.subscriptArtist(id: detailId!) {
            if self.isLikeBtnActivated == false {
                print("self.isLikeBtnActivated : \(self.isLikeBtnActivated)")
                self.likeBtn.imageView?.image =  UIImage(named: "infoConcertLikeButtonActivated")
                self.isLikeBtnActivated = true
                
                self.view.makeToast("내 공연에 추가되었습니다!")
                print("self.isLikeBtnActivated : \(self.isLikeBtnActivated)")
            } else {
                self.likeBtn.imageView?.image =  UIImage(named: "infoConcertLikeButton")
                self.isLikeBtnActivated = false
            }
        }
    }
    
    @IBAction func reservationBtnAction(_ sender: Any) {
        self.view.makeToast("내 티켓에 추가됐습니다.")
    }
    @IBOutlet weak var reservationBtn: UIButton!
    
    
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
        self.gredientView.layer.addSublayer(gradientLayer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //배경 그라데이션
        getGradientBackground()
        
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
            
            if detailData.dConcertSubscribe == true {
                self.likeBtn.setImage(UIImage(named: "infoConcertLikeButtonActivated"), for: .normal)
                self.isLikeBtnActivated = true
            } else {
                self.likeBtn.setImage(UIImage(named: "infoConcertLikeButton"), for: .normal)
                self.isLikeBtnActivated = false
            }

            
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
        
        view.addSubview(reservationBtn)
        let buttonBottomConstraint = NSLayoutConstraint(item: reservationBtn, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -12.0)

        let buttonLeftConstraint = NSLayoutConstraint(item: reservationBtn, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -10.0)
        
//        buttonBottomConstraint += NSLayoutConstraint()
        self.view.addConstraint(buttonBottomConstraint)
        self.view.addConstraint(buttonLeftConstraint)
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
