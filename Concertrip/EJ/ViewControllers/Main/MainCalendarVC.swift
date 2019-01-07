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
    @IBOutlet weak var nilView: UIView!
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    
    var sDay:DayView!
    var selectDay = Int()
    var currentCalendar: Calendar?
    var selectedIdx = Int ()
    var year_ = Int()
    var month_ = Int()
    var day_ = Int()

    var animationFinished = true
    var shouldShowDaysOut = true

    var tapList = [CalendarTap]()
    var monthlyList = [CalendarList]()
    
    //캘린더 탭
    var tapId = ""
    var tapType = ""
    
    
    //단일의 년월일 받기
    var monthArr = Array<Int>()
    var yearArr = Array<Int>()
    var dayArr = Array<Int>()
    
    var index : Int = 0
    
    let dispathGroup = DispatchGroup()
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
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        //tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()

        
        ////////////
        let ctype = "all"
        let cid = ""
        let cyear = 2019
        let cmonth = 1
        print("들어갔나요? ")
        
        CalendarListService.shared.getCalendarMonthly(type: ctype, id: cid, year: cyear, month: cmonth) { [weak self](data) in
            print("들어갔네요")
            guard let `self` = self else { return }
            self.monthlyList = data
            self.tableView.reloadData()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-d'T'HH:mm:ss.SSSZ"
            for date in data{
                for date2 in date.calendarDate! {
                    let dayFormat = DateFormatter()
                    let monFormat = DateFormatter()
                    let yearFormat = DateFormatter()
                    
                    dayFormat.dateFormat = "d"
                    monFormat.dateFormat = "M"
                    yearFormat.dateFormat = "yyyy"
                    
                    guard let date = dateFormatter.date(from: date2) else {
                        fatalError()
                    }
                    
                    let day : Int? = Int(dayFormat.string(from: date))
                    let mon : Int? = Int(monFormat.string(from: date))
                    let year : Int? = Int(yearFormat.string(from: date))
                    
                    self.dayArr.append(day!)
                    self.monthArr.append(mon!)
                    self.yearArr.append(year!)
                    
                }
            }
            print("어레이입니다 : ", self.dayArr)
            self.index = self.dayArr.count
            
            print("self.index 입니당ㅋㅋ : \(self.index)")
            self.calendarView.contentController.refreshPresentedMonth()
            
        }
        
        
        ///////////
        
        //collectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
        
        //calendarView
        self.calendarView.calendarAppearanceDelegate = self //Appearance delegate
//        self.calendarView.animatorDelegate = self // Animator delegate
        self.menuView.menuViewDelegate = self // Menu delegate
        self.calendarView.calendarDelegate = self // Calendar delegate
        
        if let currentCalendar = currentCalendar {
            monthLabel.text = CVDate(date: Date(), calendar: currentCalendar).koreanDescription
        }
        monthLabel.setTextColorToGradient(image: UIImage(named: "gradation")!)
        
        
    }
    
    func getDotService(type : String, id: String){
        let ctype = type
        let cid = id
        let cyear = 2019
        let cmonth = 1
        print("들어갔나요? ")
        
        CalendarListService.shared.getCalendarMonthly(type: ctype, id: cid, year: cyear, month: cmonth) { [weak self](data) in
            print("들어갔네요")
            guard let `self` = self else { return }
            self.monthlyList = data
            self.tableView.reloadData()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-d'T'HH:mm:ss.SSSZ"
            for date in data{
                for date2 in date.calendarDate! {
                    let dayFormat = DateFormatter()
                    let monFormat = DateFormatter()
                    let yearFormat = DateFormatter()
                    
                    dayFormat.dateFormat = "d"
                    monFormat.dateFormat = "M"
                    yearFormat.dateFormat = "yyyy"
                    
                    guard let date = dateFormatter.date(from: date2) else {
                        fatalError()
                    }
                    
                    let day : Int? = Int(dayFormat.string(from: date))
                    let mon : Int? = Int(monFormat.string(from: date))
                    let year : Int? = Int(yearFormat.string(from: date))
                    
                    self.dayArr.append(day!)
                    self.monthArr.append(mon!)
                    self.yearArr.append(year!)
                    
                }
            }
            print("어레이입니다 : ", self.dayArr)
            self.index = self.dayArr.count
            
            print("self.index 입니당ㅋㅋ : \(self.index)")
            self.calendarView.contentController.refreshPresentedMonth()
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        CalendarTapService.shared.getCalendarTap { [weak self](data) in
            guard let `self` = self else { return }
            self.tapList = data
            self.collectionView.reloadData()
        }
//        getDotService(type: tapName)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        menuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }
}


//MARK: Calendar Extension
extension MainCalendarVC: CVCalendarViewAppearanceDelegate {
    func dayLabelWeekdayOutTextColor() -> UIColor {
        return UIColor.gray
    }
    
    func dayLabelWeekdayInTextColor() -> UIColor {
        return UIColor.white
    }
}

extension MainCalendarVC: CVCalendarMenuViewDelegate, CVCalendarViewDelegate{
    
    func shouldShowWeekdaysOut() -> Bool { return shouldShowDaysOut }
    func dayOfWeekTextColor(by weekday: Weekday) -> UIColor {
        return UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
//        weekday == .sunday || weekday == .saturday  || weekday == .monday || weekday == .tuesday || weekday == .wednesday || weekday == .thursday || weekday == .friday ?
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

    func dotMarker(shouldShowOnDayView dayView: DayView) -> Bool {
        
        if !dayView.isHidden && dayView.date != nil {
            print("안녕하세요")
            print("index : ", index)
            year_ = dayView.date.year
            month_ = dayView.date.month
            day_ = dayView.date.day
            
            for i in 0 ..< index {
                print(yearArr[i], "년", monthArr[i], "월", dayArr[i], "일")
                if year_ == yearArr[i] && month_ == monthArr[i] && day_ == dayArr[i] {
                    return true
                }
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
        sDay = dayView
        selectDay = sDay.date.day
        tableView.reloadData()
        
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
        print("테이블뷰임당 : numberOfRowsInSection \(monthlyList.count)")
        
//        if selectDay ==
        return monthlyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCalendarTVCell") as! MainCalendarTVCell
        let days = monthlyList[indexPath.row]
        
        
        cell.selectionStyle = .none
    
        print("selectDay는 ? \(selectDay)")
        
        for i in 0 ..< index {
            if dayArr[i] == selectDay{
                cell.nameLabel.text = days.calendarName
                cell.profileImg.imageFromUrl(gsno(days.calendarProfileImg), defaultImgPath: "")
                cell.hashLabel.text = days.calendarTag
                
            } else {
                
            }
        }
        
        
        
        
//        let day = selectDay
//
//        for i in 0 ..< index {
//            print(yearArr[i], "년", monthArr[i], "월", dayArr[i], "일")
//            if year_ == yearArr[i] && month_ == monthArr[i] && day == dayArr[i] {
//                cell.nameLabel.text = days.calendarName
//            }
//        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let storyboard = UIStoryboard(name: "InformationSB", bundle: nil)
        let dvc = storyboard.instantiateViewController(withIdentifier: "InfSolo_ThemeVC") as! InfSolo_ThemeVC
        let days = monthlyList[indexPath.row]
        
        dvc.detailId = days.calendarId
        
        
        self.present(dvc, animated: true, completion: nil)
    }
    
    
}

//MARK: collectionView Extension

extension MainCalendarVC: UICollectionViewDataSource, UICollectionViewDelegate{
    
//    func dayLabelPresentWeekdayHighlightedBackgroundColor() -> UIColor {
//        return UIColor.white
//    }
    
    //오늘날짜에 하이라이트 되는것!
    func dayLabelPresentWeekdaySelectedBackgroundColor() -> UIColor {
        return UIColor.black
    }
    
    func dayLabelWeekdaySelectedBackgroundColor() -> UIColor {
        return UIColor(cgColor: #colorLiteral(red: 0.5843137255, green: 0.2431372549, blue: 1, alpha: 1))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("taplist.count : \(tapList.count)")
        return tapList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCalendarCVCell", for: indexPath) as! MainCalendarCVCell
        let menu = tapList[indexPath.row]
        
        cell.menuLabel.text = menu.calTapName
        if selectedIdx == indexPath.row{
            cell.menuLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        else {
            cell.menuLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIdx = indexPath.row
        let menu = tapList[indexPath.row]
        
        tapType = menu.calTapType!
        tapId = menu.calTapId!
        
        getDotService(type: tapType, id: tapId)
        
        self.calendarView.contentController.refreshPresentedMonth()
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
