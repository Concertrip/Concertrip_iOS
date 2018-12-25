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

    @IBOutlet weak var tableTopC: NSLayoutConstraint!
    @IBOutlet weak var tableBottomC: NSLayoutConstraint!
    
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    
    var selectedDay:DayView!
    var currentCalendar: Calendar?
    
    var animationFinished = true
    var shouldShowDaysOut = true

    var menuBarLabels = ["모두", "내 공연", "지코", "크러쉬", "페노메코", "힙합", "알레시카 카라"]
    var dayArrays = ["1","5","30"]
    let hashtagList = ["#3월4일 #TONIGHT #행주특별출연 #전석매진 #양양용용융융!", "#3월4일 #TONIGHT #행주특별출연 #전석매진 #양양용용융융!", "#3월4일 #TONIGHT #행주특별출연 #전석매진 #양양용용융융!", "#3월4일 #TONIGHT #행주특별출연 #전석매진 #양양용용융융!"]
    
    
    //tableview 상태 값 변수입니다.
    var tableIsVisible = false {
        didSet { //menuStatus의 값이 변경된 후에 호출됩니다.
            if !tableIsVisible {
                tableView.isUserInteractionEnabled = false
                print(tableView.isUserInteractionEnabled)
            } else {
                tableView.isUserInteractionEnabled = true
                print(tableView.isUserInteractionEnabled)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView
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
    
    
    func dotMarker(shouldShowOnDayView dayView: DayView) -> Bool{
        // Look up date in dictionary
        if( dayArrays != nil){
            return true // date is in the array so draw a dot
        }
        return false
    }
    
    
    func dotMarker(colorOnDayView dayView: DayView) -> [UIColor]{
        return [UIColor.blue]
    }

    
    func didSelectDayView(_ dayView: CVCalendarDayView, animationDidFinish: Bool) {
        selectedDay = dayView
        print(selectedDay.date.day)

        print("self.tableView.frame.origin.y 는 ? : \(self.tableView.frame.origin.y)")
        
        if !tableIsVisible { //열리자!
            tableView.isHidden = false
            tableTopC.constant = tableView.bounds.height + 280
            tableBottomC.constant = +0
            
            tableIsVisible = true
            
            //애니메이션
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
                self.view.layoutIfNeeded()
            }) { (animationComplete) in
                print("(1) The animation is complete!")
            }
        } else { //닫히자!
            
            tableTopC.constant = 280
            tableBottomC.constant = 0
            
            tableIsVisible = false
            
            //애니메이션
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
                self.view.layoutIfNeeded()
            }) { (animationComplete) in
                print("(2) The animation is complete!")
            }
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
        
//        let sellectedDay = selectedDay.date.day
//        let strDay = String(sellectedDay)
//        
//        //스트링이 잘 안넘어감!
//        if sellectedDay != nil {
//            cell.testLabel.text = "\(strDay)일"
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
        
//        cell.menuLabel.preferredMaxLayoutWidth = cell.menuLabel.bounds.width
        cell.menuLabel.text = menuBarLabels[indexPath.row]
        cell.menuLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    
    
    
    
    
}

