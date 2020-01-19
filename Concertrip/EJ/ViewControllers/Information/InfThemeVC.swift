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
    @IBOutlet weak var gradientView: UIView!
    
    var isLikeBtnActivated = false
    var detailId : String?
    var eventList = [EventList]()
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
            
            if detailData.dThemeIsSubscribe! == true {
                self.isLikeBtnActivated = true
                self.likeBtn.imageView?.image = UIImage(named : "infoLikeButtonActivated")
            }
            else {
                self.isLikeBtnActivated = false
                self.likeBtn.imageView?.image = UIImage(named: "infoLikeButton")
            }
            self.tableView.reloadData()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getThemeList()
    }
    
    func getThemeList() {
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
            
            if detailData.dThemeIsSubscribe! == true {
                self.isLikeBtnActivated = true
                self.likeBtn.imageView?.image = UIImage(named : "infoLikeButtonActivated")
            }
            else {
                self.isLikeBtnActivated = false
                self.likeBtn.imageView?.image = UIImage(named: "infoLikeButton")
            }
            self.tableView.reloadData()
        }
    }
    @IBAction func likeBtn(_ sender: Any) {
        SubscribeGenreService.shared.subscriptGenre(id: detailId!) {
            
            if self.isLikeBtnActivated == false {
                self.likeBtn.imageView?.image =  UIImage(named: "infoLikeButtonActivated")
                self.isLikeBtnActivated = true
                self.view.makeToast("내 공연에 추가되었습니다!")
                self.getThemeList()

            } else {
                self.likeBtn.imageView?.image =  UIImage(named: "infoLikeButton")
                self.isLikeBtnActivated = false
                self.view.makeToast("내 공연에서 삭제되었습니다!")
                self.getThemeList()
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
                    event.eventSubscribe = true
                    self.view.makeToast("내 공연에 추가되었습니다!")
                } else {
                    cell.addBtn.setImage(UIImage(named: "concertLikeButton"), for: .normal)
                    event.eventSubscribe = false
                }
            }
        }
        cell.themeProfileImg.imageFromUrl(event.eventProfileImg, defaultImgPath: "")
        cell.themeNameLabel.text = event.eventName
        cell.themeHashLabel.text = event.eventTag

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
