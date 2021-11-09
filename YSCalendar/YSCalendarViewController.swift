//
//  YSCalendarViewController.swift
//  YSCalendar
//
//  Created by xj on 2021/11/9.
//

import UIKit

// MARK: - 两种模式不要在同一个页面显示
class YSCalendarViewController: UIViewController {
    
    /// 翻页-日历
    fileprivate lazy var calendarPageView: YSCalendarPageView = {
        let calendar = YSCalendarPageView(frame: CGRect(x: 20, y: KNavBarH, width: KCalendarViewW, height: KCalendarPageViewH))
        return calendar
    }()
    
    /// 连续-日历
    fileprivate lazy var calendarSeriesView: YSCalendarSeriesView = {
        let calendar = YSCalendarSeriesView(frame: CGRect(x: 20, y: KNavBarH + KCalendarViewW + 30 , width: KCalendarViewW, height: KCalendarSeriesViewH))
        return calendar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        /// 翻页-日历
        self.view.addSubview(calendarPageView)
        calendarPageView.dateSelectChangeBlock = { model in
            print("------------翻页-日历-------------")
            print("------------\(model.year)-\(model.month)-\(model.day)-------------")
            print("------------\(model.chineseYear)-\(model.chineseMonth)-\(model.chineseDay)-------------")
        }
        
        /*
        /// 连续-日历
        self.view.addSubview(calendarSeriesView)
        calendarSeriesView.dateSelectChangeBlock = { model in
            print("------------连续-日历-------------")
            print("------------\(model.year)-\(model.month)-\(model.day)-------------")
            print("------------\(model.chineseYear)-\(model.chineseMonth)-\(model.chineseDay)-------------")
        }
        */
    }
    
}
