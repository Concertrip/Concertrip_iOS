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

    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    
    var selectedDay:DayView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        
    }
    
    func preliminaryView(viewOnDayView dayView: DayView) -> UIView {
        let circleView = CVAuxiliaryView(dayView: dayView, rect: dayView.frame, shape: CVShape.circle)
        circleView.fillColor = .colorFromCode(0xffc900)
        return circleView
    }

    
    
}
