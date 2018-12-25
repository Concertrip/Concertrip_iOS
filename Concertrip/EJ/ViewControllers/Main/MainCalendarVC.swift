//
//  MainCalendarVC.swift
//  Concertrip
//
//  Created by 양어진 on 22/12/2018.
//  Copyright © 2018 양어진. All rights reserved.
//

import UIKit
import CVCalendar

class MainCalendarVC: UIViewController {

    @IBOutlet weak var tableViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    
    var selectedDay:DayView!
    var currentCalendar: Calendar?
    
    var animationFinished = true
    var shouldShowDaysOut = true
    
    var selectCheck:Bool = false
    var tableCheck:Bool = false
    
    var menuBarLabels = ["모두", "최애", "지코", "크러쉬", "페노메코", "힙합", "알레시카 카라"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView
        tableView.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
        
        //collectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //bold font
        monthLabel.font = UIFont.boldSystemFont(ofSize: 27.0)
        
        // Appearance delegate [Unnecessary]
        //        self.calendarView.calendarAppearanceDelegate = self
        
        // Animator delegate [Unnecessary]
        //        self.calendarView.animatorDelegate = self
        
        // Menu delegate [Required]
        self.menuView.menuViewDelegate = self
        
        // Calendar delegate [Required]
        self.calendarView.calendarDelegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        menuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }
    


}


//MARK: Calendar Extension

extension MainCalendarVC: CVCalendarMenuViewDelegate, CVCalendarViewDelegate{
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    func firstWeekday() -> Weekday {
        return .monday
    }
    
    func didSelectDayView(_ dayView: CVCalendarDayView, animationDidFinish: Bool) {
        selectedDay = dayView
        print(selectedDay.date.day)

        print("self.tableView.frame.origin.y 는 ? : \(self.tableView.frame.origin.y)")
        
        if(selectCheck == false){
            selectCheck = true
            tableView.isHidden = false
            UIView.animate(withDuration: 1, animations: {
                self.tableView.frame.origin.y += self.tableView.bounds.height
            }, completion: nil)
            self.view.layoutIfNeeded()
            
            
        } else {
            
            UIView.animate(withDuration: 1, animations: {
                self.tableView.frame.origin.y -= self.tableView.bounds.height
            }, completion: nil)
            self.view.layoutIfNeeded()
            
            selectCheck = false
        }
    }
    
    func preliminaryView(viewOnDayView dayView: DayView) -> UIView {
        let circleView = CVAuxiliaryView(dayView: dayView, rect: dayView.frame, shape: CVShape.circle)
        circleView.fillColor = .colorFromCode(0xffc900)
        return circleView
    }
    
    func preliminaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        if (dayView.isCurrentDay) {
            return true
        }
        return false
    }
}

//MARK: tableView Extension

extension MainCalendarVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCalendarTVCell") as! MainCalendarTVCell
    
        print("selectDay는 ? \(selectedDay.date.day)")
        
        
        //스트링이 잘 안넘어감!
//        if selectedDay.date.day != nil{
//            cell.testLabel.text = "\(selectedDay.date.day)일"
//        } else {
//            cell.testLabel.text = "00일"
//        }
        
        
        
        return cell
    }
    
    
}

//MARK: collectionView Extension

extension MainCalendarVC: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuBarLabels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCalendarCVCell", for: indexPath) as! MainCalendarCVCell
        
        cell.menuLabel.text = menuBarLabels[indexPath.row]
        
        
        
        return cell
    }
    
    
    
    
}

