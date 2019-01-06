//
//  LikeVC.swift
//  Concertrip
//
//  Created by 양어진 on 29/12/2018.
//  Copyright © 2018 양어진. All rights reserved.
//

import UIKit
import Toast_Swift

class LikeVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var artistBtn: UIButton!
    @IBOutlet weak var themeBtn: UIButton!
    @IBOutlet weak var concertBtn: UIButton!
    @IBOutlet weak var nilView: UIView!
    
    var currentSub = 0
    var artistSub = 0
    var themeSub = 1
    var concertSub = 2
    
    var subList = [Subscribe]()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        //다른뷰갔다 돌아올 때 무조건 아티스트서브!
        currentSub = artistSub
        artistSubService()
        tableView.reloadData()
    }
    
    func artistSubService (){
        SubscribeService.shared.getArtistList { [weak self] (data) in
            guard let `self` = self else { return }
            self.subList = data
            self.tableView.reloadData()
        }
        artistBtn.setTitleColor(.white, for: .normal)
        themeBtn.setTitleColor( #colorLiteral(red: 0.4352941176, green: 0.4352941176, blue: 0.4352941176, alpha: 1), for: .normal)
        concertBtn.setTitleColor(#colorLiteral(red: 0.4352941176, green: 0.4352941176, blue: 0.4352941176, alpha: 1), for: .normal)
    }
    
    func themeSubService (){
        SubscribeService.shared.getThemeList { [weak self] (data) in
            guard let `self` = self else { return }
            self.subList = data
            self.tableView.reloadData()
        }
        themeBtn.setTitleColor(.white, for: .normal)
        artistBtn.setTitleColor(#colorLiteral(red: 0.4352941176, green: 0.4352941176, blue: 0.4352941176, alpha: 1), for: .normal)
        concertBtn.setTitleColor(#colorLiteral(red: 0.4352941176, green: 0.4352941176, blue: 0.4352941176, alpha: 1), for: .normal)
    }
    
    func concertSubService (){
        SubscribeService.shared.getEventList { [weak self] (data) in
            guard let `self` = self else { return }
            self.subList = data
            self.tableView.reloadData()
        }
        concertBtn.setTitleColor(.white, for: .normal)
        themeBtn.setTitleColor(#colorLiteral(red: 0.4352941176, green: 0.4352941176, blue: 0.4352941176, alpha: 1),for: .normal)
        artistBtn.setTitleColor(#colorLiteral(red: 0.4352941176, green: 0.4352941176, blue: 0.4352941176, alpha: 1), for: .normal)
    }

    @IBAction func artistTabBtn(_ sender: Any) {
        currentSub = artistSub
        artistSubService()
    }
    
    @IBAction func themeTabBtn(_ sender: Any) {
        currentSub = themeSub
        themeSubService()
    }
    
    @IBAction func concertTabBtn(_ sender: Any) {
        currentSub = concertSub
        concertSubService()
    }
}
extension LikeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if subList.count == 0 {
            nilView.isHidden = false
        } else {
            nilView.isHidden = true
        }
        return subList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikeTVCell") as! LikeTVCell
        var list = subList[indexPath.row]
        
        cell.selectionStyle = .none
        cell.nameLabel.text = list.name
        cell.profileImg.imageFromUrl(gsno(list.profileImg), defaultImgPath: "likeicon")
        cell.configure(data: list)
        
        if list.isSubscribe == true {
            cell.likeBtn.setImage(UIImage(named: "artistLikeButtonActivated"), for: .normal)
        }
        
        if self.currentSub == self.artistSub {
            cell.hashLabel.isHidden = true
        } else if self.currentSub == self.themeSub{
            cell.hashLabel.isHidden = true
        } else if self.currentSub == self.concertSub{
            cell.hashLabel.isHidden = false
        }
        
        cell.subscribeHandler = {(contentId) in
            if self.currentSub == self.artistSub {
            
                SubscribeArtistService.shared.subscriptArtist(id: contentId) {
                    if list.isSubscribe == false {
                        cell.likeBtn.setImage(UIImage(named: "infoLikeButton"), for: .normal)
                        list.isSubscribe = true
                    }
                    else {
                        cell.likeBtn.setImage(UIImage(named: "infoLikeButtonActivated"), for: .normal)
                        list.isSubscribe = true
                    }
                    
                    
                    
                    self.artistSubService()
                }
            } else if self.currentSub == self.concertSub {
            
                SubscribeEventService.shared.subscriptEvent(id: contentId) {
                    if list.isSubscribe == false {
                        cell.likeBtn.setImage(UIImage(named: "artistLikeButton"), for: .normal)
                        list.isSubscribe = true
                    }
                    else {
                        cell.likeBtn.setImage(UIImage(named: "artistLikeButtonActivated"), for: .normal)
                        list.isSubscribe = true
                    }
                    
                    self.concertSubService()
                }
                
            } else if self.currentSub == self.themeSub{
                
                SubscribeEventService.shared.subscriptEvent(id: contentId) {
                    
                    if list.isSubscribe == false {
                        cell.likeBtn.setImage(UIImage(named: "artistLikeButton"), for: .normal)
                        list.isSubscribe = true
                    }
                    else {
                        cell.likeBtn.setImage(UIImage(named: "artistLikeButtonActivated"), for: .normal)
                        list.isSubscribe = true
                    }
                    
                    self.themeSubService()
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "InformationSB", bundle: nil)
        let list = subList[indexPath.row]
        
        if self.currentSub == self.artistSub {
            if list.isGroup == true {
                let dvc = storyboard.instantiateViewController(withIdentifier: "InfGroupVC") as! InfGroupVC
                
                dvc.detailId = list.id
                
                
                self.present(dvc, animated: true, completion: nil)
            }
            else if list.isGroup == false {
                let dvc = storyboard.instantiateViewController(withIdentifier: "InfSolo_ThemeVC") as! InfSolo_ThemeVC
                
                dvc.detailId = list.id
                
                self.present(dvc, animated: true, completion: nil)
            }
        }
        else if self.currentSub == self.concertSub {
            let dvc = storyboard.instantiateViewController(withIdentifier: "InfConcertVC") as! InfConcertVC
            
            dvc.detailId = list.id
            
            
            self.present(dvc, animated: true, completion: nil)
        }
        else if self.currentSub == self.themeSub{
            let dvc = storyboard.instantiateViewController(withIdentifier: "InfThemeVC") as! InfThemeVC
            
            dvc.detailId = list.id
            self.present(dvc, animated: true, completion: nil)
        }
    }
}
