//
//  ExploreClickedVC.swift
//  Concertrip
//
//  Created by 심지원 on 2018. 12. 26..
//  Copyright © 2018년 양어진. All rights reserved.
//

import UIKit

class ExploreClickedVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var searchTxt: UITextField!
    @IBOutlet weak var searchTableView: UITableView!

    @IBOutlet weak var gradientView: UIView!
    var additionalRequest = false
    @IBOutlet weak var noResultView: UIView!
    @IBOutlet weak var noResultBtn: UIButton!
    @IBAction func noResultActionBtn(_ sender: Any) {
        self.view.makeToast("추가 요청이 완료되었습니다!")
    }
    @IBOutlet weak var noResultLabel: UILabel!
    
    var isLikeBtnActivated = false
    var selectedSection = Int()
    
    @IBOutlet weak var searchResultTableView: UITableView!
    var artistList = [Artists]()
    var eventList = [Events]()
    var genresList = [Genres]()
    
    var subscriptId : Int = 0

    @IBAction func okBtn(_ sender: Any) {
        getDataAll()
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
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTxt.delegate = self
//        let doneBtn : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: Selector("okBtn"))
        
//        textFieldShouldReturn(searchTxt)
        getGradientBackground()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        //자동으로 키보드 올라오기
        showKeyboard()
//        searchTxt.appearance().keyboardAppearance = .Dark
        //검은색 키보드
        searchTxt.keyboardAppearance = .dark

        //placeholder 색
        searchTxt.attributedPlaceholder = NSAttributedString(string: "아티스트 / 콘서트 명",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        //table 스크롤 시 키보드 Dismiss
        searchTableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag;
        //table 클릭 시 키보드 Dismiss
        searchTableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.interactive;
//        searchTxt.delegate = self as! UITextFieldDelegate
        
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        getDataAll()
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDataAll()
    }
    func showKeyboard() {
        searchTxt.becomeFirstResponder()
    }
    func hideKeyboard() {
        searchTxt.resignFirstResponder()
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
    
    func getDataAll() {
        SearchService.shared.getSearchResult(tag: searchTxt.text!) { [weak self] (value) in
            let searchData = value as SearchObject
            
            if value.artists?.count == 0 && value.events?.count == 0 && value.genres?.count == 0 {
                self?.noResultView.isHidden = false
                self?.searchTableView.isHidden = true
                self?.noResultLabel.text = "'\(self?.searchTxt.text! ?? "")'에 대한 결과가 없습니다"
                self?.noResultBtn.layer.cornerRadius = 15
                self?.noResultBtn.setTitle("'\(self?.searchTxt.text! ?? "")' 아티스트/콘서트 추가 요청하기'", for: .normal)
                
                self?.noResultBtn.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                self?.noResultBtn.setTitleColor(#colorLiteral(red: 0.3490196078, green: 0.2431372549, blue: 1, alpha: 1), for: .normal)
                
                
                //                self?.noResultBtn.isEnabled = true
                
            }
            else {
                self?.noResultView.isHidden = true
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
            
            self!.hideKeyboard()
            
        }
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
        cell.selectionStyle = .none
        
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
            cell.hashtagLabel.isHidden = true
            
            cell.subscribeHandler = {(albumId) in

                SubscribeArtistService.shared.subscriptArtist(id: albumId) {
                    if artistData.artistSubscribe == false {
                        cell.likeBtn.setImage(UIImage(named: "artistLikeButtonActivated"), for: .normal)
                        self.view.makeToast("캘린더에 추가되었습니다!")
                        artistData.artistSubscribe = true
                    }
                    else {
                        cell.likeBtn.setImage(UIImage(named: "artistLikeButton"), for: .normal)
                        self.view.makeToast("캘린더에서 삭제되었습니다!")
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
            
            cell.hashtagLabel.isHidden = true
            
            cell.subscribeHandler = {(genreId) in
                SubscribeGenreService.shared.subscriptGenre(id: genreId) {
                    if genreData.genreSubscribe == false {
                        cell.likeBtn.setImage(UIImage(named: "artistLikeButtonActivated"), for: .normal)
                        self.view.makeToast("캘린더에 추가되었습니다!")
                        genreData.genreSubscribe = true
                    }
                    else {
                        cell.likeBtn.setImage(UIImage(named: "artistLikeButton"), for: .normal)
                        self.view.makeToast("캘린더에서 삭제되었습니다!")
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
            cell.hashtagLabel.text = eventData.eventTag
            if eventData.eventSubscribe == false {
                cell.likeBtn.setImage(UIImage(named: "concertLikeButton"), for: .normal)
            }
            else {
                cell.likeBtn.setImage(UIImage(named: "concertLikeButtonActivated"), for: .normal)
            }
            
            cell.subscribeHandler = {(genreId) in
                SubscribeEventService.shared.subscriptEvent(id: genreId) {
                    if eventData.eventSubscribe == false {
                        cell.likeBtn.setImage(UIImage(named: "concertLikeButtonActivated"), for: .normal)
                        self.view.makeToast("내 공연에 추가되었습니다!")
                        eventData.eventSubscribe = true
                    }
                    else {
                        cell.likeBtn.setImage(UIImage(named: "concertLikeButton"), for: .normal)
                        eventData.eventSubscribe = false
                        self.view.makeToast("내 공연에서 삭제되었습니다!")
                    }
                    print(eventData.eventName, ": ", eventData.eventSubscribe)
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.white
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        header.backgroundView?.backgroundColor = UIColor(white: 1, alpha: 0)
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "InformationSB", bundle: nil)

        if indexPath.section == 0 {
            let artist = artistList[indexPath.row]
            if artist.artistIsGroup == true {
                let dvc = storyboard.instantiateViewController(withIdentifier: "InfGroupVC") as! InfGroupVC
                dvc.detailId = artist.artistId
                self.present(dvc, animated: true, completion: nil)
            }
            else {
                let dvc = storyboard.instantiateViewController(withIdentifier: "InfSolo_ThemeVC") as! InfSolo_ThemeVC
                dvc.detailId = artist.artistId
                self.present(dvc, animated: true, completion: nil)
            }
        }
        else if indexPath.section == 1 {
            let genre = genresList[indexPath.row]
            let dvc = storyboard.instantiateViewController(withIdentifier: "InfThemeVC") as! InfThemeVC
            dvc.detailId = genre.genreId
            self.present(dvc, animated: true, completion: nil)
        }
        else {
            let event = eventList[indexPath.row]
            let dvc = storyboard.instantiateViewController(withIdentifier: "InfConcert_2VC") as! InfConcert_2VC
            dvc.detailId = event.eventId
            self.present(dvc, animated: true, completion: nil)
        }
//        let storyboard = UIStoryboard(name: "InformationSB", bundle: nil)
//        let list = artistList[indexPath.row]
//
//        if list.artistIsGroup == true {
//            let dvc = storyboard.instantiateViewController(withIdentifier: "InfGroupVC") as! InfGroupVC
//            dvc.detailId = list.artistId
//            self.present(dvc, animated: true, completion: nil)
//        }
//        else {
//            //InfSolo_ThemeVC
//            let dvc = storyboard.instantiateViewController(withIdentifier: "InfSolo_ThemeVC") as! InfSolo_ThemeVC
//            dvc.detailId = list.artistId
//            self.present(dvc, animated: true, completion: nil)
//        }
    }
}
