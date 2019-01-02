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
    
    @IBOutlet weak var noResultView: UIView!
    @IBOutlet weak var noResultBtn: UIButton!
    @IBOutlet weak var noResultLabel: UILabel!
    
    @IBOutlet weak var searchResultTableView: UITableView!
    var searchList = [SearchObject]()
    var artistList = [Artists]()
    var eventList = [Events]()
    var genresList = [Genres]()
    
    
    @IBAction func okBtn(_ sender: Any) {
        SearchService.shared.getSearchResult(tag: searchTxt.text!) { [weak self] (value) in
            if value[0].artists?.count == 0 && value[0].events?.count == 0 && value[0].genres?.count == 0 {
                self?.noResultView.isHidden = false
                self?.noResultLabel.text = "'\(self?.searchTxt.text! ?? "")'에 대한 결과가 없습니다"
            }
            else {
                self?.searchTableView.isHidden = false
                
                
                guard let `self` = self else { return }
                
                self.searchList = value
                self.artistList = self.searchList[0].artists!
                self.eventList = self.searchList[0].events!
                self.genresList = self.searchList[0].genres!
                
                self.searchTableView.reloadData()
            }
        }
    }
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
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
        //자동으로 키보드 올라오기
        showKeyboard()
        
        //placeholder 색
        searchTxt.attributedPlaceholder = NSAttributedString(string: "아티스트 / 콘서트 명",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        //table 스크롤 시 키보드 Dismiss
        searchTableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag;
        //table 클릭 시 키보드 Dismiss
        searchTableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.interactive;
    }
    func showKeyboard() {
        searchTxt.becomeFirstResponder()
    }
    func hideKeyboard() {
        searchTxt.resignFirstResponder()
    }
    func dismissKeyboard() {

    }
}



extension ExploreClickedVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if firstData.count == 0 && secondData.count == 0 && thirdData.count == 0 {
//            searchTableView.isHidden = true
//        }
        
        if artistList.count == 0 && eventList.count == 0 && genresList.count == 0 {
            searchTableView.isHidden = true
        }
        if section == 0 {
            return artistList.count
        }
        else if section == 1 {
            return genresList.count
        }
        else {
            return eventList.count
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
        print("indexPath.row : ", indexPath.section)
        
        
        if indexPath.section == 0 {
            let artistData = artistList[indexPath.row]
            cell.nameLabel.text = artistData.artistName
            cell.profileImg.imageFromUrl(gsno(artistData.artistProfileImg), defaultImgPath: "")
            
            print(artistData)
        }
        else if indexPath.section == 1 {
            let genreData = genresList[indexPath.row]
            cell.nameLabel.text = genreData.genreName
            cell.profileImg.imageFromUrl(gsno(genreData.genreProfileImg), defaultImgPath: "")
            print(genreData)
        }
        else {
            let eventData = eventList[indexPath.row]
            cell.nameLabel.text = eventData.eventName
            cell.profileImg.imageFromUrl(gsno(eventData.eventProfileImg), defaultImgPath: "")
            print(eventData)
        }
        
        

        return cell
    }
    
    
}
