//
//  ExploreVC.swift
//  Concertrip
//
//  Created by 심지원 on 2018. 12. 25..
//  Copyright © 2018년 양어진. All rights reserved.
//

import UIKit

class ExploreVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gradientView: UIView!
    @IBAction func searchBtn(_ sender: Any) {
        //performSegue(withIdentifier: "searchPush", sender: self)
        /*
         //present
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ExploreClickedVC") as! ExploreClickedVC
        self.(nextVC, animated: true)
        */
        //push
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExploreClickedVC") as! ExploreClickedVC
        navigationController?.pushViewController(vc,
                                                 animated: true)
    }

    var artistList = [Artists]()
    var themeList = [TabTheme]()
    var menuTheme : String = ""
    
    var isLikeBtnActivated = false
    
    @IBAction func likeBtnAction(_ sender: UIButton) {
        
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
    
    
    var selectedIdx = Int ()
    //[모두] [테마] [보이그룹] [걸그룹] [힙합] [발라드/R&B] [댄스] [POP] [EDM] [인디] [재즈] [록]
    
    let menuList = ["테마", "보이그룹", "걸그룹", "힙합", "발라드", "R&B", "댄스", "POP", "EDM", "인디", "재즈", "록"]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGradientBackground()
        ThemeService.shared.getThemeList(name: "테마") { (value) in
            self.themeList = value
            self.tableView.reloadData()
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        
        menuTheme = menuList[0]
        
        
        /*
        //TextField 속성 설정
        searchTxt.attributedPlaceholder = NSAttributedString(string: "아티스트 / 콘서트명",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
         */
    }
    
    func getSearchResult() {
        SearchService.shared.getSearchResult(tag: menuList[selectedIdx]) { [weak self] (value) in
            print("network success")
            guard let `self` = self else { return }
            let searchData = value as SearchObject
            guard let artists = searchData.artists else { return }
            self.artistList = artists
            self.tableView.reloadData()
            self.collectionView.reloadData()
        }
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultPush" {
            let txt = searchTxt.text
            let dvc = segue.destination as! ExploreClickedVC
            dvc.resStr = txt
        }
    }
 */
}

extension ExploreVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exploreCVCell", for: indexPath) as! ExploreCVCell
        let menu = menuList[indexPath.row]
        print("이게 뭐지? ", menu)
        cell.menuLabel.text = menu
        print("뭐가 눌리지? :", selectedIdx)
        if selectedIdx == indexPath.row {
            print("뭐지정렬 : ",cell.menuLabel.text)
            cell.menuLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        else {
            cell.menuLabel.textColor = #colorLiteral(red: 0.4352941176, green: 0.4352941176, blue: 0.4352941176, alpha: 1)
        }
        return cell
    }
    
    //선택 시
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIdx = indexPath.row
        if selectedIdx == 0 {
            ThemeService.shared.getThemeList(name: "테마") { (value) in
                self.themeList = value
                self.tableView.reloadData()
                self.collectionView.reloadData()
            }
        }
        else {
            getSearchResult()
        }
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

extension ExploreVC : UICollectionViewDelegateFlowLayout {
    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                         sizeForItemAt indexPath: IndexPath) -> CGSize {
        let menu = menuList[indexPath.row]
        let width  = Int(menu.widthWithConstrainedHeight(height: 26, font: UIFont.systemFont(ofSize: 15)))
        return CGSize(width: width+25, height: 26)
    }
}


extension ExploreVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedIdx == 0 {
            return themeList.count
        }
        return artistList.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exploreTVCell") as! ExploreTVCell
        
        cell.selectionStyle = .none
//        var artistData = artistList[indexPath.row]
        
//        cell.profileImg.imageFromUrl(gsno(artistData.artistProfileImg), defaultImgPath: "")
//        cell.nameLabel.text = artistData.artistName
        
//        let name = nameList[indexPath.row]
//        let hashtag = hashtagList[indexPath.row]
//
//        cell.nameLabel.text = name
//        cell.hashtagLabel.text = hashtag
//        cell.selectionStyle = .none
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "exploreTVCell", for: indexPath) as! ExploreTVCell
        if selectedIdx == 0 {
            //테마 선택시......... 아래 else문 참고
            var themeData = themeList[indexPath.row]
            cell.nameLabel.text = themeData.themeName
            cell.profileImg.imageFromUrl(gsno(themeData.themeProfileImg), defaultImgPath: "")
            print("테마 데이터! ", themeData)
            var themeSubscribe : Bool = false
            
            if themeData.themeSubscribe! == false {
                themeSubscribe = false
                cell.likeBtn.setImage(UIImage(named: "artistLikeButton"), for: .normal)
            }
            else {
                themeSubscribe = true
                cell.likeBtn.setImage(UIImage(named: "artistLikeButtonActivated"), for: .normal)
            }
            
            cell.configureTheme(data: themeData)
            cell.subscribeHandler = {(themeId) in
                SubscribeGenreService.shared.subscriptGenre(id: themeId) {
                    print("SubscribeTheme network working!")
                    if themeSubscribe == false {
                        cell.likeBtn.setImage(UIImage(named: "artistLikeButtonActivated"), for: .normal)
                        self.view.makeToast("내 공연에 추가되었습니다!")
                        themeData.themeSubscribe = true
                    }
                    else {
                        cell.likeBtn.setImage(UIImage(named: "artistLikeButton"), for: .normal)
                        themeData.themeSubscribe = false
                    }
                }
            }
        }
        else {
            var artistData = artistList[indexPath.row]
            cell.profileImg.imageFromUrl(gsno(artistData.artistProfileImg), defaultImgPath: "")
            cell.nameLabel.text = artistData.artistName
            
            var artistSubscribe : Bool = false
            
            if artistData.artistSubscribe == false {
                artistSubscribe = false
                cell.likeBtn.setImage(UIImage(named: "artistLikeButton"), for: .normal)
            }
            else {
                artistSubscribe = true
                cell.likeBtn.setImage(UIImage(named: "artistLikeButtonActivated"), for: .normal)
            }
            cell.configureArtist(data : artistData)

            cell.subscribeHandler = {(artistId) in
                SubscribeArtistService.shared.subscriptArtist(id: artistId) {
                    print("network working!")
                    if artistSubscribe == false {
                        cell.likeBtn.setImage(UIImage(named: "artistLikeButtonActivated"), for: .normal)
                        self.view.makeToast("내 공연에 추가되었습니다!")
                        artistData.artistSubscribe = true
                    }
                    else {
                        cell.likeBtn.setImage(UIImage(named: "artistLikeButton"), for: .normal)
                        artistData.artistSubscribe = false
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let storyboard = UIStoryboard(name: "InformationSB", bundle: nil)
        if selectedIdx == 0 {
            let list = themeList[indexPath.row]
            let dvc = storyboard.instantiateViewController(withIdentifier: "InfThemeVC") as! InfThemeVC
            dvc.detailId = list.themeId
            self.present(dvc, animated: true, completion: nil)
        }
        else {
            let list = artistList[indexPath.row]
            
            if list.artistIsGroup == true {
                let dvc = storyboard.instantiateViewController(withIdentifier: "InfGroupVC") as! InfGroupVC
                dvc.detailId = list.artistId
                self.present(dvc, animated: true, completion: nil)
            }
            else {
                //InfSolo_ThemeVC
                let dvc = storyboard.instantiateViewController(withIdentifier: "InfSolo_ThemeVC") as! InfSolo_ThemeVC
                dvc.detailId = list.artistId
                self.present(dvc, animated: true, completion: nil)
            }
        }
    }
}
