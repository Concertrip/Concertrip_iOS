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
    var cautionList = [PrecautionList]()
    var seatNameList:[String] = []
    var seatPriceList:[String] = []
    var namePriceList:[String] = []
    var dateTxt  = ""
    var priceTxt = ""
    var attributeList: [NSMutableAttributedString] = []
    
    @IBAction func backBtnAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func likeBtnAction(_ sender: Any) {
        print("디테일아이디 \(detailId)")
        SubscribeEventService.shared.subscriptEvent(id: detailId!) {
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
        ReservationService.shared.reservationTicket(id: detailId!) {
            self.view.makeToast("내 티켓에 추가됐습니다.")
        }
    }
    @IBOutlet weak var reservationBtn: UIButton!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    //그라데이션 배경
    func getGradientBackground(){
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.frame.size = self.gredientView.frame.size
        gradientLayer.colors = [UIColor(cgColor: #colorLiteral(red: 0.05882352941, green: 0.06274509804, blue: 0.09019607843, alpha: 1)).cgColor,UIColor(cgColor: #colorLiteral(red: 0, green: 0.01176470588, blue: 0.1607843137, alpha: 1)).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        self.gredientView.layer.addSublayer(gradientLayer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //배경 그라데이션
        getGradientBackground()
        
//        scrollView.addSubview(infoImg)
        scrollView.contentSize = infoImg.bounds.size
        
        print("detailId : \(gsno(detailId))")
        bigProfileImg.circleImageView()
        DetailEventService.shared.getConcertDetailList(id: detailId!) { [weak self] (data) in
            guard let `self` = self else { return }
            let detailData = data as DetailConcert
            guard let members = detailData.dConcertMemberList else { return }
            guard let cautions = detailData.dConcertPrecautionList else { return }
            self.memberList = members
            self.cautionList = cautions
            
            print("memberList : \(self.memberList)")
            print("cautionList : \(self.cautionList)")
            
            self.concertLocationLabel.text = detailData.dConcertLocation
            self.bigProfileImg.imageFromUrl(detailData.dConcertProfileImg, defaultImgPath: "")
            self.backgroundImg.imageFromUrl(detailData.dConcertBackImg, defaultImgPath: "")
            self.likeCountLabel.text = String(detailData.dConcertSubscribeNum!)
            let youtubeURL = detailData.dConcertYoutubeUrl
            self.youtubeView.loadVideoID(youtubeURL!)
            self.nameLabel.text = detailData.dConcertName
//            self.infoImg.imageFromUrl(detailData.dConcertEventInfoImg, defaultImgPath: "")
            
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
            
//            let dateFormatterGet = DateFormatter()
//            dateFormatterGet.dateFormat = "dd/MM/yyyy"
//            var result = Date()
//            var dateResult = String()
//            for data? in detailData.dConcertDate {
//                if data == nil {
//                    self.dateTxt += ""
//                }
//                else {
//                    result = dateFormatterGet.date(from: data)!
//                    self.dateTxt += "\(result)"
//                }
//            }
            
            for data in detailData.dConcertDate! {
                self.dateTxt += data + "\n"
            }
            
            for i in 0 ..< self.seatNameList.count {
                self.priceTxt += "■ " +  self.seatNameList[i] + " : " + self.seatPriceList[i] + "\n"
            }
            
            
            
            self.concertDateLabel.text = self.dateTxt
            self.concertPriceLabel.text = self.priceTxt
            
            
            let strNumber: NSString = self.priceTxt as NSString
            let range = (strNumber).range(of: "■")
            let attribute = NSMutableAttributedString.init(string: strNumber as String)
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(cgColor: #colorLiteral(red: 0.2431372549, green: 0.737254902, blue: 1, alpha: 1)) , range: range)
//            self.attributeList.append(attribute)
            self.concertPriceLabel.attributedText = attribute
            
            
            print("self.concertPriceLabel.text : \(self.concertPriceLabel.text!)")
            
            
            
            self.performerCollectionView.reloadData()
            self.cautionCollectionView.reloadData()
        }
        
        
        
        performerCollectionView.delegate = self
        performerCollectionView.dataSource = self
        cautionCollectionView.delegate = self
        cautionCollectionView.dataSource = self
        
        performerCollectionView.tag = 1
        cautionCollectionView.tag = 2
        
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
        
//        if collectionView == self.performerCollectionView{
//            print("memberList.count : \(memberList.count)")
//            return memberList.count
//
//        } else if collectionView == self.cautionCollectionView {
//            print("cautionList.count \(cautionList.count)")
//            return cautionList.count
//        }
        
        if collectionView.tag == 1 {
            return memberList.count
        } else if collectionView.tag == 2 {
            return cautionList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 1 {
            let cell = performerCollectionView.dequeueReusableCell(withReuseIdentifier: "InfConcertPerformerCVCell", for: indexPath) as! InfConcertPerformerCVCell
            let member = memberList[indexPath.item]
            
            cell.profileImg.imageFromUrl(gsno(member.memProfileImg), defaultImgPath: "")
            cell.nameLabel.text = member.memName
            
            return cell
        } else if collectionView.tag == 2 {
            let cell = cautionCollectionView.dequeueReusableCell(withReuseIdentifier: "InfConcertCautionCVCell", for: indexPath) as! InfConcertCautionCVCell
            let cautions = cautionList[indexPath.item]
            
            cell.cautionLabel.text = cautions.cautionName
            
//            뭔가 url이상한듯..?
//            cell.cautionImg.imageFromUrl(gsno(cautions.cautionImg), defaultImgPath: "")
            switch cautions.cautionCode {
            case 101: cell.cautionImg.image = UIImage(named: "allAgeLimitIcon")
            case 102: cell.cautionImg.image = UIImage(named: "7AgeLimitIcon")
            case 103: cell.cautionImg.image = UIImage(named: "8AgeLimitIcon")
            case 104: cell.cautionImg.image = UIImage(named: "10AgeLimitIcon")
            case 105: cell.cautionImg.image = UIImage(named: "12AgeLimitIcon")
            case 106: cell.cautionImg.image = UIImage(named: "13AgeLimitIcon")
            case 107: cell.cautionImg.image = UIImage(named: "14AgeLimitIcon")
            case 108: cell.cautionImg.image = UIImage(named: "15AgeLimitIcon")
            case 109: cell.cautionImg.image = UIImage(named: "19AgeLimitIcon")
                
            case 201: cell.cautionImg.image = UIImage(named: "foodAllowIcon")
            case 202: cell.cautionImg.image = UIImage(named: "foodLimitIcon")
                
                //203 이름겹쳐서 아이콘 안받음
            case 203: cell.cautionImg.image = UIImage(named: "waterAllowIcon")
            case 204: cell.cautionImg.image = UIImage(named: "waterLimitIcon")
            
            case 301: cell.cautionImg.image = UIImage(named: "photoAllowIcon")
            case 302: cell.cautionImg.image = UIImage(named: "photoLimitIcon")
                
            case 401: cell.cautionImg.image = UIImage(named: "reEntryAllowIcon")
            case 402: cell.cautionImg.image = UIImage(named: "reEntryLimitIcon")
                
            case 501: cell.cautionImg.image = UIImage(named: "ticketLimit1Icon")
            case 502: cell.cautionImg.image = UIImage(named: "ticketLimit2Icon")
                
                //503 504 아이콘 없음
            case 503: cell.cautionImg.image = UIImage(named: "ticketLimit2Icon")
            case 504: cell.cautionImg.image = UIImage(named: "ticketLimit2Icon")
            default: cell.cautionImg.image = UIImage(named: "artistProfileImage")
            }
            
            return cell
        } else {
            let cell = cautionCollectionView.dequeueReusableCell(withReuseIdentifier: "InfConcertCautionCVCell", for: indexPath) as! InfConcertCautionCVCell
            
            return cell
        }
        
    }
}

