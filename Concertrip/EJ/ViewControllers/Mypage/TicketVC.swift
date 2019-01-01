//
//  TicketVC.swift
//  Concertrip
//
//  Created by 양어진 on 31/12/2018.
//  Copyright © 2018 양어진. All rights reserved.
//

import UIKit

class TicketVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var ticketList = [Ticket]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        TicketService.shared.getTicketList { [weak self] (data) in
            guard let `self` = self else { return }
            self.ticketList = data
            self.tableView.reloadData()
        }
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
        
        cell.concertNameLabel.text = ticket.ticketName
        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MM/dd HH:mm"
//        cell.concertDateLabel.text = formatter.string(from: ticket.ticketDate ?? Date())
        
        cell.concertDateLabel.text = "날짜 : \(ticket.ticketDate!)"
        cell.concertLocationLabel.text = "장소 : \(ticket.ticketLocation!)"
        
        return cell
    }
    
    
    
}
