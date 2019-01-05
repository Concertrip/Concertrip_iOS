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
    
    let menuList = ["테마", "보이그룹", "걸그룹", "힙합", "발라드/R&B", "댄스", "POP", "EDM", "인디", "재즈", "록"]
    let nameList = ["자라섬 재즈페스티벌", "SAMM HANSHAW", "PHUM VIPHURIT", "ALESSICA CARA"]
    let hashtagList = ["#오늘밤 #12월25일 #MERRYCHRISTMAS #JAZZ", "#오늘밤 #12월25일 #MERRYCHRISTMAS #JAZZ", "#오늘밤 #12월25일 #MERRYCHRISTMAS #JAZZ", "#오늘밤 #12월25일 #MERRYCHRISTMAS #JAZZ"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        
        let menu = menuList[0]
        print(menu)
        
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
        
        cell.menuLabel.text = menu
        
        if selectedIdx == indexPath.row{
            cell.menuLabel.textColor = #colorLiteral(red: 0.3490196078, green: 0.2431372549, blue: 1, alpha: 1)
        }
        else {
            cell.menuLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        return cell
    }
    
    //선택 시
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIdx = indexPath.row
        getSearchResult()
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
        return artistList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exploreTVCell") as! ExploreTVCell
        
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
        var artistData = artistList[indexPath.row]
        cell.profileImg.imageFromUrl(gsno(artistData.artistProfileImg), defaultImgPath: "")
        cell.nameLabel.text = artistData.artistName
        if artistData.artistSubscribe == false {
            cell.likeBtn.setImage(UIImage(named: "artistLikeButton"), for: .normal)
        }
        else {
            cell.likeBtn.setImage(UIImage(named: "artistLikeButtonActivated"), for: .normal)
        }
        cell.configureArtist(data : artistData)

        cell.subscribeHandler = {(artistId) in
            print("앨범아듸 : ", artistId)
            SubscribeArtistService.shared.subscriptArtist(id: artistId) {
                print("network working!")
                if artistData.artistSubscribe == false {
                    
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let storyboard = UIStoryboard(name: "InformationSB", bundle: nil)
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
