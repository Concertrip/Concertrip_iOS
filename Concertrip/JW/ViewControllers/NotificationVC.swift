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
    @IBOutlet weak var gradientView: UIView!
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    var alarmList = [Alarm]()
    
//    let titleList = ["다니엘 시저 첫 내한공연", "SAMM HANSHAW 내한공연 - DOUBT", "2018 스카 슈퍼스웩 페스티벌 <ADAM LAMBERT 특별출연>", "ALESSICA CARA의 GROWING PAIN 공연"]
//    let hashtagList = ["#3월4일 #TONIGHT #행주특별출연 #전석매진 #양양용용융융!", "#3월4일 #TONIGHT #행주특별출연 #전석매진 #양양용용융융!", "#3월4일 #TONIGHT #행주특별출연 #전석매진 #양양용용융융!", "#3월4일 #TONIGHT #행주특별출연 #전석매진 #양양용용융융!"]
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getGradientBackground()
        AlarmService.shared.getAlarmList {[weak self] (data) in
            guard let `self` = self else { return }
            self.alarmList = data
            self.noticeTable.reloadData()
        }

        noticeTable.delegate = self
        noticeTable.dataSource = self
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
        print("alarmList.count \(alarmList.count)")
        return alarmList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = noticeTable.dequeueReusableCell(withIdentifier: "NoticeCell") as! NotificationVCCell
        let alarm = alarmList[indexPath.row]
        
        cell.titleTxt.text = alarm.alarmTitle
        cell.hashtagTxt.text = alarm.alarmBody
        

        cell.selectionStyle = .none
        
        return cell
    }
}


