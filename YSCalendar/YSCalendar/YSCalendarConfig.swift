//
//  YSCalendarConfig.swift
//  XJSwiftKit
//
//  Created by xj on 2021/11/2.
//

import UIKit

// MARK: -  定义颜色

public let Color_System = UIColor(named: "Color_System") ?? UIColor.black // App主题色

public let Color_333333_333333 = UIColor(named: "Color_333333_333333") ?? UIColor.black

public let Color_666666_666666 = UIColor(named: "Color_666666_666666") ?? UIColor.black

public let Color_999999_999999 = UIColor(named: "Color_999999_999999") ?? UIColor.black

// Screen width
let KScreenW: CGFloat = UIScreen.main.bounds.width

// Screen height
let KScreenH: CGFloat = UIScreen.main.bounds.height

// StatusBar
let KStatusBarH: CGFloat = UIApplication.shared.statusBarFrame.height

// Navbar
let KNavBarH: CGFloat = KStatusBarH + 44

let KCalendarPageRow: Int = 6       // 分页行
let KCalendarSeriesRow: Int = 4     // 行
let KCalendarColum: Int = 7

let KCalendarMarginH: CGFloat = 5 // 水平间距
let KCalendarMarginV: CGFloat = 5 // 垂直间距

// 日历控件宽度
let KCalendarViewW = KScreenW - 40

// day高度
let KCalendarDayCellH: CGFloat = (((KCalendarViewW - CGFloat(KCalendarColum + 1) * KCalendarMarginH)) / CGFloat(KCalendarColum))

// 日历控件高度
let KCalendarPageViewH: CGFloat = (KCalendarDayCellH * CGFloat(KCalendarPageRow) + CGFloat(KCalendarPageRow + 1) * KCalendarMarginV + 50.0)

let KCalendarSeriesViewH: CGFloat = (KCalendarDayCellH * CGFloat(KCalendarSeriesRow) + CGFloat(KCalendarSeriesRow + 1) * KCalendarMarginV + 50.0)

// Series
var KCurrentIndexPath: IndexPath = IndexPath.init(item: 0, section: 0)

// Page
var KCurrentPageIndexPath: IndexPath = IndexPath.init(item: 0, section: 0)

// MARK: - 日历配置
struct YSCalendarConfig {
    
    static let startYear: Int = 2020
    static let endYear: Int = 2022
    
    // 当天日期
    static let nowYear: Int = YSDateTool.currentYear()
    static let nowMonth: Int = YSDateTool.currentMonth()
    static let nowDay: Int = YSDateTool.currentDay()

    // 选中高亮日期
    static var currentYear: Int = nowYear
    static var currentMonth: Int = nowMonth
    static var currentDay: Int = nowDay
    
    static var dayModel: YSDayModel = YSDayModel()

    // 是否是当天日期
    static func isNowDate(_ dayModel: YSDayModel) -> Bool {
        return (dayModel.year == nowYear &&
                dayModel.month == nowMonth &&
                dayModel.day == nowDay)
    }

    // 是否是选中高亮日期
    static func isCurrentDate(_ dayModel: YSDayModel) -> Bool {
        return (dayModel.year == currentYear &&
                dayModel.month == currentMonth &&
                dayModel.day == currentDay)
    }
    
    /// 重设选中高亮日期
    static func resetCurrentDate() {
        currentYear = nowYear
        currentMonth = nowMonth
        currentDay = nowDay
    }

    // 设置选中高亮日期
    static func setCurrentDate(_ dayModel: YSDayModel) {
        currentYear = dayModel.year
        currentMonth = dayModel.month
        currentDay = dayModel.day
        print("current = \(currentYear) - \(currentMonth) - \(currentDay)")
    }

    // 设置选中高亮日期
    static func setCurrentDate(year: Int, month: Int, day: Int) {
        currentYear = year
        currentMonth = month
        currentDay = day
        print("current = \(currentYear) - \(currentMonth) - \(currentDay)")
    }
}

/// 为UICollectionViewCell扩展属性
fileprivate var indexPathCellKey: String = "UITableViewCellIndexPathKey"
fileprivate var pageIndexPathCellKey: String = "UITableViewCellpageIndexPathCellKey"
extension UICollectionViewCell {
    
    var indexPath: IndexPath? {
        set {
             objc_setAssociatedObject(self, &indexPathCellKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return (objc_getAssociatedObject(self, &indexPathCellKey)) as? IndexPath
        }
    }
    
    var pageIndexPath: IndexPath? {
        set {
             objc_setAssociatedObject(self, &pageIndexPathCellKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return (objc_getAssociatedObject(self, &pageIndexPathCellKey)) as? IndexPath
        }
    }
}
