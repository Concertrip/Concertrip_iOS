//
//  NotificationVC.swift
//  Concertrip
//
//  Created by 심지원 on 2018. 12. 25..
//  Copyright © 2018년 양어진. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController {

  
    
    @IBOutlet weak var noticeTable: UITableView!
    
    @IBAction func backBtn(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    let titleList = ["다니엘 시저 첫 내한공연", "SAMM HANSHAW 내한공연 - DOUBT", "2018 스카 슈퍼스웩 페스티벌 <ADAM LAMBERT 특별출연>", "ALESSICA CARA의 GROWING PAIN 공연"]
    let hashtagList = ["#3월4일 #TONIGHT #행주특별출연 #전석매진 #양양용용융융!", "#3월4일 #TONIGHT #행주특별출연 #전석매진 #양양용용융융!", "#3월4일 #TONIGHT #행주특별출연 #전석매진 #양양용용융융!", "#3월4일 #TONIGHT #행주특별출연 #전석매진 #양양용용융융!"]
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        noticeTable.delegate = self
        noticeTable.dataSource = self
        
    }
}

extension NotificationVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //화면 전환시
        /*
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
        let music = musicList[indexPath.row]
        nextVC.albumImg = music.albumImg
        nextVC.musicTitle = music.musicTitle
        nextVC.singer = music.singer
        print(nextVC)
        navigationController?.pushViewController(nextVC, animated: true)
        */
    }
}

extension NotificationVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = noticeTable.dequeueReusableCell(withIdentifier: "NoticeCell") as! NotificationVCCell
        
        let title = titleList[indexPath.row]
        let hashtag = hashtagList[indexPath.row]
        
        cell.titleTxt.text = title
        cell.hashtagTxt.text = hashtag
        cell.selectionStyle = .none
        
        return cell
    }
}


