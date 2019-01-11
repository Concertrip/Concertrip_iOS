//
//  SplashVC.swift
//  Concertrip
//
//  Created by 양어진 on 11/01/2019.
//  Copyright © 2019 양어진. All rights reserved.
//

import UIKit
import Lottie

class SplashVC: UIViewController {

    @IBOutlet weak var gradationView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        user 3번 토큰!
//        eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjb25jZXJ0cmlwIiwidXNlcklkeCI6M30.bhZBALpki1bnn-WISKrI-CVFU-9NhrYNIZgIKAHN-YA
        
        let animationView = LOTAnimationView(name: "data")
        animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFill
        animationView.loopAnimation = false
        
        view.addSubview(animationView)
            
        animationView.play(completion: { (true) in
            print("done playing")
            
            //메인뷰 뜨게하기
//            if let tabViewController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as? tabBarController {
//                self.present(tabViewController, animated: true, completion: nil)
//            }
            
            //튜토리얼뷰 뜨게하기
            let dvc = self.storyboard?.instantiateViewController(withIdentifier: "ZeroTabVC") as! ZeroTabVC
            self.present(dvc, animated: true, completion: nil)
        })
        
        getGradientBackground()
    }
    
    func getGradientBackground(){
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.frame.size = self.view.frame.size
        gradientLayer.colors = [UIColor(cgColor: #colorLiteral(red: 0.05882352941, green: 0.06274509804, blue: 0.09019607843, alpha: 1)).cgColor,UIColor(cgColor: #colorLiteral(red: 0, green: 0.01176470588, blue: 0.1607843137, alpha: 1)).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        self.gradationView.layer.addSublayer(gradientLayer)
    }
    

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
