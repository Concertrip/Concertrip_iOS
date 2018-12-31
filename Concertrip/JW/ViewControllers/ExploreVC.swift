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
    
    var selectedIdx = Int ()
    
    
    let menuList = ["모두", "테마", "POP", "JAZZ", "CLASSIC", "R&B", "ELECTRONIC"]
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
        //cell 객체를 선언합니다. reusable identifier를 제대로 설정해주는거 잊지마세요!
        let cell = tableView.dequeueReusableCell(withIdentifier: "exploreTVCell") as! ExploreTVCell
        
        //각 row에 해당하는 cell의 데이터를 넣어주기위해 모델에서 music 데이터 하나를 선언합니다.
        let name = nameList[indexPath.row]
        let hashtag = hashtagList[indexPath.row]
        
        //위에서 가져온 데이터를 각 cell에 넣어줍니다.
        cell.nameLabel.text = name
        cell.hashtagLabel.text = hashtag
        
        //위의 과정을 마친 cell 객체를 반환합니다.
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
