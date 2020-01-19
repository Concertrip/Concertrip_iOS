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
    var noticeList = [Notifications]()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGradientBackground()

        NotificationService.shared.getNotification() { [weak self] (data) in
            guard let `self` = self else { return }
            self.noticeList = data
            self.noticeTable.reloadData()
        }

        noticeTable.delegate = self
        noticeTable.dataSource = self
    }
    
    //그라데이션 배경
    func getGradientBackground() {
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

    }
}

extension NotificationVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("개수 : ", noticeList.count)
        return noticeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = noticeTable.dequeueReusableCell(withIdentifier: "NoticeCell") as! NotificationVCCell
        let notice = noticeList[indexPath.row]
        
        cell.titleTxt.text = notice.noticeTitle
        cell.hashtagTxt.text = notice.noticeBody
        cell.profileImg.imageFromUrl(gsno(notice.noticeImg), defaultImgPath: "")

        cell.selectionStyle = .none
        
        return cell
    }
}


