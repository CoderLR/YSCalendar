//
//  YSDayModel.swift
//  XJSwiftKit
//
//  Created by xj on 2021/11/2.
//

import Foundation

// MARK: - 当月天
enum YSDayType {
    case current
    case last
    case next
}

// MARK: - 数据
public struct YSDayModel {
    /// 公历
    var year: Int = 1970
    var month: Int = 1
    var day: Int = 1
    var week: Int = 1
    
    /// 农历
    var chineseYear: String = ""
    var chineseMonth: String = ""
    var chineseDay: String = ""
    
    /// indexPath
    var indexPath: IndexPath = IndexPath.init(item: 0, section: 0)
    
    /// 当月天
    var dayType: YSDayType = .current
    
    /// 获取选中高亮的indexPath
    /// - Parameter monthModels: 数据模型数组
    /// - Returns: IndexPath
    static func getIndexPath(_ monthModels: [[YSDayModel?]]) -> IndexPath {
        var indexPath = IndexPath.init(item: 0, section: 0)
        let dayModels = monthModels[KCurrentPageIndexPath.item]
        for i in 0..<dayModels.count {
            guard let dayModel = dayModels[i] else { return indexPath }
            if dayModel.year == YSCalendarConfig.currentYear &&
                dayModel.month == YSCalendarConfig.currentMonth &&
                dayModel.day == YSCalendarConfig.currentDay {
                indexPath = dayModel.indexPath
                break
            }
        }
        return indexPath
    }
    
    /// 根据日期获取YSDayModel
    /// - Parameters:
    ///   - date: Date
    ///   - index: 天数索引
    ///   - dayType: 属于当月
    /// - Returns: YSDayModel
    static func getDayModel(date: Date, index: Int, dayType: YSDayType) -> YSDayModel {
        var model = YSDayModel()
        // 公历
        model.day = index + 1
        model.year = YSDateTool.currentYear(date: date)
        model.month = YSDateTool.currentMonth(date: date)
        
        // 农历
        let currentDate = YSDateTool.dateStringToDate("\(model.year)-\(model.month)-\(model.day)")
        model.chineseDay = YSDateTool.currentChineseDay(date: currentDate)
        model.chineseYear = YSDateTool.currentChineseYear(date: currentDate)
        model.chineseMonth = YSDateTool.currentChineseMonth(date: currentDate)
        
        // 星期
        model.week = YSDateTool.currentWeekDay(date: currentDate)
        
        // 类型
        model.dayType = dayType
        
        return model
    }
    
    /// 获取（分页）日历数据
    /// - Returns: 数据模型数组
    static func getDatePageList() -> [[YSDayModel?]] {
        var monthArray: [[YSDayModel?]] = []
        var dayArray: [YSDayModel?] = []
        
        var currentDate = YSDateTool.dateStringToDate("\(YSCalendarConfig.startYear)-01-01")
        
        while YSDateTool.currentYear(date: currentDate) <= YSCalendarConfig.endYear {
            
            dayArray.removeAll() // 移除上月数据
            
            // 当月第一天是星期几
            let dayInWeek = YSDateTool.firstWeekDayInCurrentMonth(date: currentDate)
            // 当月天数
            let days = YSDateTool.countOfDaysInCurrentMonth(date: currentDate)
            // 上月天数
            let lastMonth = YSDateTool.lastMonth(date: currentDate)
            let lastDays = YSDateTool.countOfDaysInCurrentMonth(date: lastMonth)
            // 下月天数
            let nextMonth = YSDateTool.nextMonth(date: currentDate)
            //let nextDays = YSDateTool.countOfDaysInCurrentMonth(date: nextMonth)
            
            // 上月
            for j in 0..<dayInWeek {
                var model = getDayModel(date: lastMonth, index: lastDays - dayInWeek + j, dayType: .last)
                model.indexPath = IndexPath.init(item: dayArray.count, section: 0)
                dayArray.append(model)
            }

            // 当月
            for i in 0..<days {
                var model = getDayModel(date: currentDate, index: i, dayType: .current)
                model.indexPath = IndexPath.init(item: dayArray.count, section: 0)
                if YSCalendarConfig.isNowDate(model) {
                    KCurrentIndexPath = model.indexPath
                    KCurrentPageIndexPath = IndexPath.init(item: monthArray.count, section: 0)
                    YSCalendarConfig.dayModel = model
                }
                
                dayArray.append(model)
            }
            
            // 下月
            for k in 0..<(42 - days - dayInWeek) {
                var model = getDayModel(date: nextMonth, index: k, dayType: .next)
                model.indexPath = IndexPath.init(item: dayArray.count, section: 0)
                dayArray.append(model)
            }
            
            // 拼接数据
            monthArray.append(dayArray)
            
            // 继续获取下月数据
            currentDate = YSDateTool.nextMonth(date: currentDate)
        }
        return monthArray
    }

    /// 获取（连续）日历数据
    /// - Returns: 数据模型数组
    static func getDateList() -> [YSDayModel?] {
        var dayArray: [YSDayModel?] = []

        var currentDate = YSDateTool.dateStringToDate("\(YSCalendarConfig.startYear)-10-01")
        
        // 当月第一天是星期几
        let dayInWeek = YSDateTool.firstWeekDayInCurrentMonth(date: currentDate)
        
        // 上月天数
        let lastMonth = YSDateTool.lastMonth(date: currentDate)
        let lastDays = YSDateTool.countOfDaysInCurrentMonth(date: lastMonth)
        
        // 上月
        for j in 0..<dayInWeek {
            var model = getDayModel(date: lastMonth, index: lastDays - dayInWeek + j, dayType: .last)
            model.indexPath = IndexPath.init(item: dayArray.count, section: 0)
            dayArray.append(model)
        }
        
        while YSDateTool.currentYear(date: currentDate) <= YSCalendarConfig.endYear {
            
            // 当月有多少天
            let days = YSDateTool.countOfDaysInCurrentMonth(date: currentDate)

            // 生成当月数据
            for i in 0..<days {
                var model = getDayModel(date: currentDate, index: i, dayType: .current)
                model.indexPath = IndexPath.init(item: dayArray.count, section: 0)
                if YSCalendarConfig.isNowDate(model) {
                    KCurrentIndexPath = model.indexPath
                    YSCalendarConfig.dayModel = model
                }
                dayArray.append(model)
            }
            // 继续获取下月数据
            currentDate = YSDateTool.nextMonth(date: currentDate)
        }
        return dayArray
    }
}
