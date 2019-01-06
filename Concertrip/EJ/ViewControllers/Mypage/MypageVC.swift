//
//  MypageVC.swift
//  Concertrip
//
//  Created by 양어진 on 31/12/2018.
//  Copyright © 2018 양어진. All rights reserved.
//

import UIKit

class MypageVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var concertNameLabel: UILabel!
    @IBOutlet weak var concertLocationLabel: UILabel!
    @IBOutlet weak var concertDateLabel: UILabel!
    
    var managerArr = ["적립금", "쿠폰", "예매확인/취소", "리뷰", "배송지관리", "주문/배송조회", "결제수단", "고객센터"]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    @IBAction func ticketAction(_ sender: Any) {
    }
}

extension MypageVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MypageCVCell", for: indexPath) as! MypageCVCell
        let manage = managerArr[indexPath.row]
        
        cell.manageLabel.text = manage
        
        
        return cell
    }
    
    
    
    
}
