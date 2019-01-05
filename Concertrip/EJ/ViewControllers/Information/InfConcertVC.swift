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
    var dateTxt  = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performerCollectionView.delegate = self
        performerCollectionView.dataSource = self
//        cautionCollectionView.delegate = self
//        cautionCollectionView.dataSource = self
//        tableView.delegate = self
//        tableView.dataSource = self

        print("detailId : \(gsno(detailId))")
       
        DetailEventService.shared.getConcertDetailList(id: detailId!) { [weak self] (data) in
            guard let `self` = self else { return }
            let detailData = data as DetailConcert
            guard let members = detailData.dConcertMemberList else { return }
            self.memberList = members
            
            print("hihi")
            
            for data in detailData.dConcertDate! {
                self.dateTxt += data + "\n"
            }
            
            print("dateTxt : \(self.dateTxt)")
            self.concertDateLabel.text = self.dateTxt
            self.concertLocationLabel.text = detailData.dConcertLocation
            self.bigProfileImg.imageFromUrl(detailData.dConcertProfileImg, defaultImgPath: "")
            self.backgroundImg.imageFromUrl(detailData.dConcertBackImg, defaultImgPath: "")
            self.likeCountLabel.text = String(detailData.dConcertSubscribeNum!)
            let youtubeURL = detailData.dConcertYoutubeUrl
            self.youtubeView.loadVideoID(youtubeURL!)
            self.nameLabel.text = detailData.dConcertName
            
        }
    }
    
    @IBAction func likeBtnAction(_ sender: Any) {
        if isLikeBtnActivated == false {
            simpleOnlyOKAlertwithHandler(title: "캘린더에 추가되었습니다!", message: "") { (okAction) in
                self.likeBtn.imageView?.image =  UIImage(named: "artistLikeButtonActivated")
                self.isLikeBtnActivated = true
            }
        } else {
            simpleOnlyOKAlertwithHandler(title: "캘린더에서 삭제되었습니다!", message: "") { (okAction) in
                self.likeBtn.imageView?.image =  UIImage(named: "artistLikeButton")
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
        print("memberList.count : \(memberList.count)")
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

//
//extension InfConcertVC : UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//
//}

