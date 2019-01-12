//
//  ZeroTabVC.swift
//  Concertrip
//
//  Created by 심지원 on 2019. 1. 9..
//  Copyright © 2019년 양어진. All rights reserved.
//

import UIKit

class ZeroTabVC: UIViewController {
    @IBOutlet weak var gradientView: UIView!
    
    @IBOutlet weak var likeImg: UIImageView!
    @IBOutlet weak var musicGradation: UIImageView!
    @IBOutlet weak var idolGradation: UIImageView!
    @IBOutlet weak var hiphopGradation: UIImageView!
    @IBOutlet weak var baladGradation: UIImageView!
    @IBOutlet weak var visitGradation: UIImageView!
    @IBOutlet weak var edmGradation: UIImageView!
    @IBOutlet weak var indiGradation: UIImageView!
    @IBOutlet weak var jazzGradation: UIImageView!
    @IBOutlet weak var rockGradation: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    
    var musicIsSelect = false
    var idolIsSelect = false
    var hiphopIsSelect = false
    var baladIsSelect = false
    var visitIsSelect = false
    var edmIsSelect = false
    var indiIsSelect = false
    var jazzIsSelect = false
    var rockIsSelect = false
    
    /*
     5c373797edc59445b3dbca4a
     "힙합 공연 모음"
     
     5c373797edc59445b3dbca4b
     "아이돌 공연 모음"
     
     5c373797edc59445b3dbca4c
     "뮤직 페스티벌 공연 모음"
     
     5c373797edc59445b3dbca4d
     "EDM 페스티벌 모음"
     
     5c373797edc59445b3dbca4e
     "내한 공연 모음"
     
     5c373797edc59445b3dbca4f
     "발라드/R&B 공연 모음"
     
     5c373797edc59445b3dbca50
     "재즈 공연 모음"
     
     5c373797edc59445b3dbca51
     "인디 공연 모음"
     
     5c373797edc59445b3dbca52
     "락 공연 모음"
*/
    
    @IBAction func musicFestBtn(_ sender: Any) {
        if musicIsSelect == false {
            musicGradation.isHidden = false
            musicIsSelect = true
        } else {
            musicGradation.isHidden = true
            musicIsSelect = false
        }
        likeImgChange()
        subscribeGenre(id: "5c373797edc59445b3dbca4c")
    }
    @IBAction func idolBtn(_ sender: Any) {
        if idolIsSelect == false {
            idolGradation.isHidden = false
            idolIsSelect = true
        } else {
            idolGradation.isHidden = true
            idolIsSelect = false
        }
        likeImgChange()
        subscribeGenre(id: "5c373797edc59445b3dbca4b")
    }
    
    @IBAction func hiphopBtn(_ sender: Any) {
        if hiphopIsSelect == false {
            hiphopGradation.isHidden = false
            hiphopIsSelect = true
        } else {
            hiphopGradation.isHidden = true
            hiphopIsSelect = false
        }
        likeImgChange()
        subscribeGenre(id: "5c373797edc59445b3dbca4a")
    }
    
    @IBAction func baladBtn(_ sender: Any) {
        if baladIsSelect == false {
            baladGradation.isHidden = false
            baladIsSelect = true
        } else {
            baladGradation.isHidden = true
            baladIsSelect = false
        }
        likeImgChange()
        subscribeGenre(id: "5c373797edc59445b3dbca4f")
    }
    
    @IBAction func visitBtn(_ sender: Any) {
        if visitIsSelect == false {
            visitGradation.isHidden = false
            visitIsSelect = true
        } else {
            visitGradation.isHidden = true
            visitIsSelect = false
        }
        likeImgChange()
        subscribeGenre(id: "5c373797edc59445b3dbca4e")
    }
    
    @IBAction func edmBtn(_ sender: Any) {
        if edmIsSelect == false {
            edmGradation.isHidden = false
            edmIsSelect = true
        } else {
            edmGradation.isHidden = true
            edmIsSelect = false
        }
        likeImgChange()
        subscribeGenre(id: "5c373797edc59445b3dbca4d")
    }
    
    @IBAction func indiBtn(_ sender: Any) {
        if indiIsSelect == false {
            indiGradation.isHidden = false
            indiIsSelect = true
        } else {
            indiGradation.isHidden = true
            indiIsSelect = false
        }
        likeImgChange()
        subscribeGenre(id: "5c373797edc59445b3dbca51")
    }
    @IBAction func jazzBtn(_ sender: Any) {
        if jazzIsSelect == false {
            jazzGradation.isHidden = false
            jazzIsSelect = true
        } else {
            jazzGradation.isHidden = true
            jazzIsSelect = false
        }
        likeImgChange()
        subscribeGenre(id: "5c373797edc59445b3dbca50")
    }
    
    @IBAction func rockBtn(_ sender: Any) {
        if rockIsSelect == false {
            rockGradation.isHidden = false
            rockIsSelect = true
        } else {
            rockGradation.isHidden = true
            rockIsSelect = false
        }
        likeImgChange()
        subscribeGenre(id: "5c373797edc59445b3dbca52")
    }
    
    
    @IBAction func nextBtnAction(_ sender: Any) {
        if let tabViewController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as? tabBarController {
            self.present(tabViewController, animated: true, completion: nil)
        }
    }
    
    func subscribeGenre(id : String){
        SubscribeGenreService.shared.subscriptGenre(id: id) {
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGradientBackground()

    }
    
    //like Img change
    func likeImgChange(){
        if musicIsSelect == false && idolIsSelect == false && hiphopIsSelect == false && baladIsSelect == false && visitIsSelect == false && edmIsSelect == false && indiIsSelect == false && jazzIsSelect == false && rockIsSelect == false {
            likeImg.image = UIImage(named: "themeLikeButton")
            nextBtn.setTitle("건너뛰기", for: .normal)
        } else {
            likeImg.image = UIImage(named: "themeLikeButtonActivated")
            nextBtn.setTitle("구독하기", for: .normal)
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

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
