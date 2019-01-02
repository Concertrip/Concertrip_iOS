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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        artistSubService()
    }
    
    func artistSubService (){
        SubscribeService.shared.getArtistList { [weak self] (data) in
            guard let `self` = self else { return }
            self.subList = data
            self.tableView.reloadData()
        }
        artistBtn.setTitleColor(.black, for: .normal)
        themeBtn.setTitleColor( #colorLiteral(red: 0.4352941176, green: 0.4352941176, blue: 0.4352941176, alpha: 1), for: .normal)
        concertBtn.setTitleColor(#colorLiteral(red: 0.4352941176, green: 0.4352941176, blue: 0.4352941176, alpha: 1), for: .normal)
    }
    
    func themeSubService (){
        SubscribeService.shared.getThemeList { [weak self] (data) in
            guard let `self` = self else { return }
            self.subList = data
            self.tableView.reloadData()
        }
        themeBtn.setTitleColor(.black, for: .normal)
        artistBtn.setTitleColor(#colorLiteral(red: 0.4352941176, green: 0.4352941176, blue: 0.4352941176, alpha: 1), for: .normal)
        concertBtn.setTitleColor(#colorLiteral(red: 0.4352941176, green: 0.4352941176, blue: 0.4352941176, alpha: 1), for: .normal)
    }
    
    func concertSubService (){
        SubscribeService.shared.getEventList { [weak self] (data) in
            guard let `self` = self else { return }
            self.subList = data
            self.tableView.reloadData()
        }
        concertBtn.setTitleColor(.black, for: .normal)
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
        print("subArtistList : \(subList.count)")
        
        if subList.count == 0 {
            nilView.isHidden = false
        } else {
            nilView.isHidden = true
        }
        return subList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikeTVCell") as! LikeTVCell
        let list = subList[indexPath.row]
        
        print("list.name : \(list.name!)")
        
        cell.selectionStyle = .none
        cell.nameLabel.text = list.name
        cell.profileImg.imageFromUrl(gsno(list.profileImg), defaultImgPath: "likeicon")
        
        if list.isSubscribe == true {
            cell.likeBtn.setImage(UIImage(named: "artistLikeButtonActivated"), for: .normal)
            cell.likeBtn.addTarget(self, action: #selector(tappedLikeBtn(_:)), for: .touchUpInside)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("like DidSelectRowAt : \(indexPath.row)")
        
        let storyboard = UIStoryboard(name: "InformationSB", bundle: nil)
        let dvc = storyboard.instantiateViewController(withIdentifier: "InfGroupVC") as! InfGroupVC
        self.present(dvc, animated: true, completion: nil)
    }
    
    
    //구독취소버튼 post 서비스 작성!
    @objc func tappedLikeBtn(_ sender : UIButton ){
        self.view.makeToast("tappedLikeBtn~~~!")
    }
}
