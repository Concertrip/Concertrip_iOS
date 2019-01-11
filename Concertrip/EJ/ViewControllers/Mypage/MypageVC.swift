//
//  MypageVC.swift
//  Concertrip
//
//  Created by 양어진 on 31/12/2018.
//  Copyright © 2018 양어진. All rights reserved.
//

import UIKit
import Toast_Swift

class MypageVC: UIViewController {
    @IBOutlet weak var gradientVeiw: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var concertNameLabel: UILabel!
    @IBOutlet weak var concertLocationLabel: UILabel!
    @IBOutlet weak var concertDateLabel: UILabel!
    @IBOutlet weak var ticketImg: UIImageView!
    
    @IBAction func payBtn(_ sender: Any) {
        self.view.makeToast("준비 중입니다.")
    }
    
    @IBOutlet weak var ticketBtn: UIButton!
    
    var ticketList = [String]()
    var manageList: [Payment] = []
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setManageData()
        getGradientBackground()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        TicketService.shared.getTicketList { [weak self] (data) in
            guard let `self` = self else { return }
            self.ticketList = data

            if self.ticketList.count == 0 {
                self.ticketBtn.setImage(UIImage(named: "ticketBigNothing"), for: .normal)
                self.ticketImg.isHidden = true
            } else {
                self.ticketBtn.setImage(UIImage(named: ""), for: .normal)
                self.ticketImg.isHidden = false
                self.ticketImg.imageFromUrl(self.gsno(self.ticketList[0]), defaultImgPath: "")
            }
        }
    }

    @IBAction func ticketAction(_ sender: Any) {
    }
    
    //그라데이션 배경
    func getGradientBackground(){
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.frame.size = self.view.frame.size
        gradientLayer.colors = [UIColor(cgColor: #colorLiteral(red: 0.05882352941, green: 0.06274509804, blue: 0.09019607843, alpha: 1)).cgColor,UIColor(cgColor: #colorLiteral(red: 0, green: 0.01176470588, blue: 0.1607843137, alpha: 1)).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        self.gradientVeiw.layer.addSublayer(gradientLayer)
    }
}

extension MypageVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MypageCVCell", for: indexPath) as! MypageCVCell
        let manage = manageList[indexPath.item]
        
        cell.manageLabel.text = manage.paymentTitle
        cell.manageImg.image = manage.paymentImg
        
        
        return cell
    }
}

extension MypageVC {
    func setManageData() {
        let manage1 = Payment(title: "적립금", imgName: "pointIcon")
        let manage2 = Payment(title: "쿠폰", imgName: "couponIcon")
        let manage3 = Payment(title: "예매확인/취소", imgName: "reservationIcon")
        let manage4 = Payment(title: "리뷰", imgName: "reviewIcon")
        let manage5 = Payment(title: "배송지관리", imgName: "addressIcon")
        let manage6 = Payment(title: "주문/배송조회", imgName: "orderIcon")
        let manage7 = Payment(title: "결제수단", imgName: "payIcon")
        let manage8 = Payment(title: "고객센터", imgName: "csIcon")
        
        manageList = [manage1, manage2,  manage3, manage4, manage5, manage6,  manage7, manage8]
    }
}
