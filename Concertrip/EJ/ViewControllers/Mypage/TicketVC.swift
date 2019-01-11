//
//  TicketVC.swift
//  Concertrip
//
//  Created by 양어진 on 31/12/2018.
//  Copyright © 2018 양어진. All rights reserved.
//

import UIKit

class TicketVC: UIViewController {

    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var ticketList = [Ticket]()
    var ticketComming = [TicketComming]()
    var ticketComplete = [TicketComplete]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGradientBackground()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        TicketService.shared.getTicketList { [weak self] (data) in
            guard let `self` = self else { return }
            self.ticketList = data
            self.tableView.reloadData()
            
            
            print("self.ticketList \(self.ticketList)")
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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

extension TicketVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("numberOfRowsInSection \(ticketList.count)")
        return ticketList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TicketTVCell") as! TicketTVCell
        let ticket = ticketList[indexPath.row]
        
    
        
        cell.ticketImg.imageFromUrl(gsno(ticket.data![0]), defaultImgPath: "")
        
        
        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MM/dd HH:mm"
//        cell.concertDateLabel.text = formatter.string(from: ticket.ticketDate ?? Date())
        
        
        
        return cell
    }
    
    
    
}
