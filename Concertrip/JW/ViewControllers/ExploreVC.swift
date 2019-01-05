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
    
    var searchList = [SearchObject]()
    var artistList = [Artists]()
    
    var isLikeBtnActivated = false
    
    @IBAction func likeBtnAction(_ sender: UIButton) {
        
        if isLikeBtnActivated == false {
            sender.setImage(UIImage(named: "artistLikeButtonActivated"), for: .normal)
            self.view.makeToast("내 공연에 추가되었습니다!")
            self.isLikeBtnActivated = true
            
        } else {
            sender.setImage(UIImage(named: "artistLikeButton"), for: .normal)
            self.isLikeBtnActivated = false
        }
    }
    
    
    var selectedIdx = Int ()
    //[모두] [테마] [보이그룹] [걸그룹] [힙합] [발라드/R&B] [댄스] [POP] [EDM] [인디] [재즈] [록]
    
    let menuList = ["모두", "테마", "보이그룹", "걸그룹", "힙합", "발라드/R&B", "댄스", "POP", "EDM", "인디", "재즈", "록"]
    let nameList = ["자라섬 재즈페스티벌", "SAMM HANSHAW", "PHUM VIPHURIT", "ALESSICA CARA"]
    let hashtagList = ["#오늘밤 #12월25일 #MERRYCHRISTMAS #JAZZ", "#오늘밤 #12월25일 #MERRYCHRISTMAS #JAZZ", "#오늘밤 #12월25일 #MERRYCHRISTMAS #JAZZ", "#오늘밤 #12월25일 #MERRYCHRISTMAS #JAZZ"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self 
        /*
        //TextField 속성 설정
        searchTxt.attributedPlaceholder = NSAttributedString(string: "아티스트 / 콘서트명",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
 */
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

extension ExploreVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exploreTVCell") as! ExploreTVCell
        
        let name = nameList[indexPath.row]
        let hashtag = hashtagList[indexPath.row]
        
        cell.nameLabel.text = name
        cell.hashtagLabel.text = hashtag
        cell.selectionStyle = .none
        
        return cell
    }
    
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
        let menu = menuList[selectedIdx]
        SearchService.shared.getSearchResult(tag: menu) { [weak self] (value) in
            guard let `self` = self else { return }
            
            self.searchList = value
            self.artistList = self.searchList[0].artists!
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreTVCell", for: indexPath) as! ExploreTVCell
        var artistData = artistList[indexPath.row]
        cell.profileImg.imageFromUrl(gsno(artistData.artistProfileImg), defaultImgPath: "")
        cell.nameLabel.text = artistData.artistName
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
        
        self.collectionView.reloadData()
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
