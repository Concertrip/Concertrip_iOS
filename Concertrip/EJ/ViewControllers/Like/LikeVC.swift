//
//  LikeVC.swift
//  Concertrip
//
//  Created by 양어진 on 29/12/2018.
//  Copyright © 2018 양어진. All rights reserved.
//

import UIKit

class LikeVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var currentSub = 0
    var artistSub = 0
    var themeSub = 1
    var concertSub = 2
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func artistTabBtn(_ sender: Any) {
        if currentSub != artistSub{

        }
    }
    
    @IBAction func themeTabBtn(_ sender: Any) {
        if currentSub != themeSub{
            
        }
    }
    
    @IBAction func concertTabBtn(_ sender: Any) {
        if currentSub != artistSub{
            
        }
    }
    
}
extension LikeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikeTVCell") as! LikeTVCell
        
        return cell
    }
    
    
    
    
}
