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

    @IBOutlet weak var maskView: UIView!
    
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    
    var selectedDay:DayView!
    var currentCalendar: Calendar?
    var selectedIdx = Int ()

    var animationFinished = true
    var shouldShowDaysOut = true

    var tapList = [CalendarTap]()
    var monthlyList = [CalendarList]()
    
    
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
        collectionView.reloadData()
        
        //calendarView
//        self.calendarView.calendarAppearanceDelegate = self //Appearance delegate
//        self.calendarView.animatorDelegate = self // Animator delegate
        self.menuView.menuViewDelegate = self // Menu delegate
        self.calendarView.calendarDelegate = self // Calendar delegate
        
        if let currentCalendar = currentCalendar {
            monthLabel.text = CVDate(date: Date(), calendar: currentCalendar).koreanDescription
        }
        monthLabel.setTextColorToGradient(image: UIImage(named: "gradation")!)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        CalendarTapService.shared.getCalendarTap { [weak self](data) in
            guard let `self` = self else { return }
            self.tapList = data
            self.collectionView.reloadData()
        }
        
        var Ctype = "all"
        var id = ""
       
        
//        CalendarListService.shared.getCalendarMonthly(type: <#T##String#>, id: <#T##String#>, year: <#T##String#>, month: <#T##String#>) { [weak self](data) in
//
//            guard let `self` = self else { return }
//            print("data : \(data)")
//            self.monthlyList = data
//
//
//            print("self.monthlyList : \(self.monthlyList)")
//        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        menuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }
    


}


//MARK: Calendar Extension

extension MainCalendarVC: CVCalendarMenuViewDelegate, CVCalendarViewDelegate{
    
    func shouldShowWeekdaysOut() -> Bool { return shouldShowDaysOut }
    //토요일 일요일 빨간색처리.
    func dayOfWeekTextColor(by weekday: Weekday) -> UIColor {
//        return weekday == .sunday || weekday == .saturday ?
        return weekday == .sunday ?
            UIColor(red: 1.0, green: 0, blue: 0, alpha: 1.0) : UIColor.black
    }
    
    func weekdaySymbolType() -> WeekdaySymbolType {
        return .short
    }
    
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    func firstWeekday() -> Weekday {
        return .monday
    }
    
    func presentedDateUpdated(_ date: CVDate) {
        if monthLabel.text != date.koreanDescription && self.animationFinished {
            let updatedMonthLabel = UILabel()
            updatedMonthLabel.textColor = monthLabel.textColor
            updatedMonthLabel.font = monthLabel.font
            updatedMonthLabel.textAlignment = .center
            updatedMonthLabel.text = date.koreanDescription
            updatedMonthLabel.sizeToFit()
            updatedMonthLabel.alpha = 0
            updatedMonthLabel.center = self.monthLabel.center
            
            let offset = CGFloat(48)
            updatedMonthLabel.transform = CGAffineTransform(translationX: 0, y: offset)
            updatedMonthLabel.transform = CGAffineTransform(scaleX: 1, y: 0.1)
            
            UIView.animate(withDuration: 0.35, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.animationFinished = false
                self.monthLabel.transform = CGAffineTransform(translationX: 0, y: -offset)
                self.monthLabel.transform = CGAffineTransform(scaleX: 1, y: 0.1)
                self.monthLabel.alpha = 0
                
                updatedMonthLabel.alpha = 1
                updatedMonthLabel.transform = CGAffineTransform.identity
                
            }) { _ in
                
                self.animationFinished = true
                self.monthLabel.frame = updatedMonthLabel.frame
                self.monthLabel.text = updatedMonthLabel.text
                self.monthLabel.transform = CGAffineTransform.identity
                self.monthLabel.alpha = 1
                updatedMonthLabel.removeFromSuperview()
            }
            
            self.view.insertSubview(updatedMonthLabel, aboveSubview: self.monthLabel)
        }
    }
    
//    func dotMarker(shouldShowOnDayView dayView: DayView) -> Bool{
//        // Look up date in dictionary
//        if( dayArrays != nil){
//            return true // date is in the array so draw a dot
//        }
//        return false
//    }
    
//    func dotMarker(shouldShowOnDayView dayView: CVCalendarDayView) -> Bool {
//
//        let day = dayView.date.day //To get the Day from the Calender
//        let month = dayView.date.month
//
//        //day 인트값!을 넣어주면 ,, 점이 true~~
////        if day == CVDate(date: NSDate() as Date).day{
////            return true
////        }
////        return false
////        var dotArray = [NSDate]() {
////            didSet{
////                self.calendarView?.contentController.refreshPresentedMonth()
////            }
////        }
//
//        if day == 1 && month == 12{
//            return true
//        }
//        return false
//    }
    
    func dotMarker(shouldShowOnDayView dayView: DayView) -> Bool {
        
        if !dayView.isHidden && dayView.date != nil {
            
            let year = dayView.date.year
            let month = dayView.date.month
            let day = dayView.date.day
            
            if year == 2019 && month == 1 && day >= 11 && day <= 13 {
                return true
            }
        }
        
        return false
    }
    
    
    func dotMarker(colorOnDayView dayView: DayView) -> [UIColor]{
        switch dayView.date.day {
        case 11:
            return [UIColor.orange]
        case 12:
            return [UIColor.orange, UIColor.green]
        default:
            return [UIColor.orange, UIColor.green, UIColor.blue]
        }
    }
    
    func dotMarker(moveOffsetOnDayView dayView: DayView) -> CGFloat {
        return 20
    }
    
    func dotMarker(sizeOnDayView dayView: DayView) -> CGFloat {
        return 5
    }
    
    func dayLabelFont(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIFont { return UIFont.systemFont(ofSize: 14)
    }

    
    func didSelectDayView(_ dayView: CVCalendarDayView, animationDidFinish: Bool) {
        selectedDay = dayView
        print(selectedDay.date.day)

        print("self.tableView.frame.origin.y 는 ? : \(self.tableView.frame.origin.y)")
        
//        if !tableIsVisible { //dissmiss애니매이션
//
//            tableView.isHidden = false
//
//
//            tableIsVisible = true
//
//            //애니메이션
//            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
//
//                self.view.layoutIfNeeded()
//            }) { (animationComplete) in
//                print("The animation is complete!")
//            }
//        } else { //show애니매이션!
//
//            tableIsVisible = false
//
//            //애니메이션
//            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
//
//                self.view.layoutIfNeeded()
//            }) { (animationComplete) in
//                print("The animation is complete!")
//
//            }
//        }
        
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
        cell.selectionStyle = .none
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let storyboard = UIStoryboard(name: "InformationSB", bundle: nil)
        let dvc = storyboard.instantiateViewController(withIdentifier: "InfGroupVC") as! InfGroupVC
        self.present(dvc, animated: true, completion: nil)
    }
    
    
}

//MARK: collectionView Extension

extension MainCalendarVC: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("taplist.count : \(tapList.count)")
        return tapList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCalendarCVCell", for: indexPath) as! MainCalendarCVCell
        let menu = tapList[indexPath.row]
        
        cell.menuLabel.text = menu.calTapName
        if selectedIdx == indexPath.row{
            cell.menuLabel.textColor = #colorLiteral(red: 0.3490196078, green: 0.2431372549, blue: 1, alpha: 1)
        }
        else {
            cell.menuLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIdx = indexPath.row
        self.collectionView.reloadData()
    }
}


extension MainCalendarVC: UICollectionViewDelegateFlowLayout{
    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                         sizeForItemAt indexPath: IndexPath) -> CGSize {
        let menu = tapList[indexPath.row]
        let width  = Int(menu.calTapName!.widthWithConstrainedHeight(height: 26, font: UIFont.systemFont(ofSize: 15)))
        return CGSize(width: width+25, height: 26)
    }
}


extension UILabel {
    func setTextColorToGradient(image: UIImage) {
        UIGraphicsBeginImageContext(frame.size)
        image.draw(in: bounds)
        let myGradient = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.textColor = UIColor(patternImage: myGradient!)
    }
}
