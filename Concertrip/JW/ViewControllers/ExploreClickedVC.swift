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
    
    var isLikeBtnActivated = false
    
    @IBOutlet weak var searchResultTableView: UITableView!
    var artistList = [Artists]()
    var eventList = [Events]()
    var genresList = [Genres]()
    
    var subscriptId : Int = 0
    
    @IBAction func okBtn(_ sender: Any) {
        SearchService.shared.getSearchResult(tag: searchTxt.text!) { [weak self] (value) in
            let searchData = value as SearchObject

            if value.artists?.count == 0 && value.events?.count == 0 && value.genres?.count == 0 {
                self?.noResultView.isHidden = false
                self?.noResultLabel.text = "'\(self?.searchTxt.text! ?? "")'에 대한 결과가 없습니다"
            }
            else {
                self?.searchTableView.isHidden = false
                
                
                guard let `self` = self else { return }
                
                guard let artist = searchData.artists else {return}
                self.artistList = artist
                guard let event = searchData.events else {return}
                self.eventList = event
                guard let genre = searchData.genres else {return}
                self.genresList = genre
                
                self.searchTableView.reloadData()
            }
        }
    }
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    
    var idx : String = ""
    
    @IBAction func likeBtn(_ sender: Any) {
        
        
//        if isLikeBtnActivated == false {
//            sender.setImage(UIImage(named: "artistLikeButtonActivated"), for: .normal)
//            self.view.makeToast("내 공연에 추가되었습니다!")
//            self.isLikeBtnActivated = true
//
//        } else {
//            sender.setImage(UIImage(named: "artistLikeButton"), for: .normal)
//            self.isLikeBtnActivated = false
//        }
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
        //cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        if indexPath.section == 0 {
            var artistData = artistList[indexPath.row]
            cell.configureZero(data : artistData)
            cell.nameLabel.text = artistData.artistName
            cell.profileImg.imageFromUrl(gsno(artistData.artistProfileImg), defaultImgPath: "")
            if artistData.artistSubscribe == false {
                cell.likeBtn.setImage(UIImage(named: "artistLikeButton"), for: .normal)
            }
            else {
                cell.likeBtn.setImage(UIImage(named: "artistLikeButtonActivated"), for: .normal)
            }
            
            cell.subscribeHandler = {(albumId) in

                SubscribeArtistService.shared.subscriptArtist(id: albumId) {
                    if artistData.artistSubscribe == false {
                        cell.likeBtn.setImage(UIImage(named: "artistLikeButtonActivated"), for: .normal)
                        artistData.artistSubscribe = true
                    }
                    else {
                        cell.likeBtn.setImage(UIImage(named: "artistLikeButton"), for: .normal)
                        artistData.artistSubscribe = false
                    }
                }
            }
        }
        else if indexPath.section == 1 {
            var genreData = genresList[indexPath.row]
            cell.configureOne(data : genreData)

            cell.nameLabel.text = genreData.genreName
            cell.profileImg.imageFromUrl(gsno(genreData.genreProfileImg), defaultImgPath: "")
            
            if genreData.genreSubscribe == false {
                cell.likeBtn.setImage(UIImage(named: "artistLikeButton"), for: .normal)
            }
            else {
                cell.likeBtn.setImage(UIImage(named: "artistLikeButtonActivated"), for: .normal)
            }
            
            cell.subscribeHandler = {(genreId) in
                SubscribeGenreService.shared.subscriptGenre(id: genreId) {
                    if genreData.genreSubscribe == false {
                        cell.likeBtn.setImage(UIImage(named: "artistLikeButtonActivated"), for: .normal)
                        genreData.genreSubscribe = true
                    }
                    else {
                        cell.likeBtn.setImage(UIImage(named: "artistLikeButton"), for: .normal)
                        genreData.genreSubscribe = false
                    }
                }
            }
        }
        else {
            var eventData = eventList[indexPath.row]
            cell.configureTwo(data: eventData)
            cell.nameLabel.text = eventData.eventName
            cell.profileImg.imageFromUrl(gsno(eventData.eventProfileImg), defaultImgPath: "")
            if eventData.eventSubscribe == false {
                cell.likeBtn.setImage(UIImage(named: "artistLikeButton"), for: .normal)
            }
            else {
                cell.likeBtn.setImage(UIImage(named: "artistLikeButtonActivated"), for: .normal)
            }
            
            cell.subscribeHandler = {(genreId) in
                SubscribeEventService.shared.subscriptEvent(id: genreId) {
                    if eventData.eventSubscribe == false {
                        cell.likeBtn.setImage(UIImage(named: "artistLikeButtonActivated"), for: .normal)
                        eventData.eventSubscribe = true
                    }
                    else {
                        cell.likeBtn.setImage(UIImage(named: "artistLikeButton"), for: .normal)
                        eventData.eventSubscribe = false
                    }
                    print(eventData.eventName, ": ", eventData.eventSubscribe)
                }
            }
        }
        
        return cell
    }
}
