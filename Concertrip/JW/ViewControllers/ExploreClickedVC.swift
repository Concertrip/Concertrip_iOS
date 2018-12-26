//
//  ExploreClickedVC.swift
//  Concertrip
//
//  Created by 심지원 on 2018. 12. 26..
//  Copyright © 2018년 양어진. All rights reserved.
//

import UIKit

class ExploreClickedVC: UIViewController {

    @IBOutlet weak var searchTxt: UITextField!
    @IBOutlet weak var searchTableView: UITableView!
    @IBAction func okBtn(_ sender: Any) {
        
    }
    
    var resStr: String?
    
    //let firstData = ["1", "2", "3", "4", "5"]
    let firstData : NSArray = []
    
    let secondData: NSArray = []
    
    let thirdData : NSArray = []
    //let thirdData = ["2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        searchTxt.text = resStr
    }
}



extension ExploreClickedVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if firstData.count == 0 && secondData.count == 0 && thirdData.count == 0 {
            searchTableView.isHidden = true
        }
        if section == 0 {
            return firstData.count
        }
        else if section == 1 {
            return secondData.count
        }
        else {
            return thirdData.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "아티스트"
        }
        else if section == 1 {
            return "테마"
        }
        else {
            return "콘서트"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreClickedVCCell") as! ExploreClickedVCCell

        cell.nameLabel.text = "이름"
        cell.hashtagLabel.text = "#hashtag"
        
        return cell
    }
    
    
}
