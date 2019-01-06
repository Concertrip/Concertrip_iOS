//
//  SettingVC.swift
//  Concertrip
//
//  Created by 양어진 on 31/12/2018.
//  Copyright © 2018 양어진. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var settingArr = ["공지사항", "푸시알림 설정", "문의하기","캘린더 추가 요청하기", "서비스 이용약관", "공연 기획사 제휴 문의" ]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

extension SettingVC: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTVCell") as! SettingTVCell
        let setting = settingArr[indexPath.row]
        cell.selectionStyle = .none
        cell.settingLabel.text = setting
        
        
        return cell
    }
    
    
}
