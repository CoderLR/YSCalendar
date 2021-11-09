//
// YSDateTool.swift
// XJSwiftKit
//
// Created by Mr.Yang on 2021/10/20.
//

import UIKit

// MARK: - 当前时间相关
class YSDateTool {
  
    // MARK: - 今年
    static func currentYear(date: Date = Date()) -> Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year, .month, .day], from: date)
        return com.year!
    }
  
    // MARK: - 今月
    static func currentMonth(date: Date = Date()) -> Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year, .month, .day], from: date)
        return com.month!
    }
  
    // MARK: - 今日
    static func currentDay(date: Date = Date()) -> Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year, .month, .day], from: date)
        return com.day!
    }
    
    // MARK: - 今天星期几
    static func currentWeekDay(date: Date = Date()) -> Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.weekday], from: date)
        return com.weekday!
    }
    
    // MARK: - 农历今年
    static func currentChineseYear(date: Date = Date()) -> String {
        let calendar = NSCalendar.init(calendarIdentifier: .chinese)
        let com = calendar?.components([.year], from: date)
        return numberToChina(yearNum: (com?.year)!) + "年"
    }
    
    // MARK: - 农历今月
    static func currentChineseMonth(date: Date = Date()) -> String {
        let calendar = NSCalendar.init(calendarIdentifier: .chinese)
        let com = calendar?.components([.month], from: date)
        return numberToChina(monthNum: (com?.month)!)
    }

    // MARK: - 农历今日
    static func currentChineseDay(date: Date = Date()) -> String {
        let calendar = NSCalendar.init(calendarIdentifier: .chinese)
        let com = calendar?.components([.day], from: date)
        return numberToChina(dayNum: (com?.day)!)
    }
    
    // MARK: - 农历今日
    static func currentChineseDayInt(date: Date = Date()) -> Int {
        let calendar = NSCalendar.init(calendarIdentifier: .chinese)
        let com = calendar?.components([.day], from: date)
        return (com?.day)!
    }
    
    // MARK: - 农历星期
    static func currentChineseWeekYear(date: Date = Date()) -> String {
        let calendar = NSCalendar.init(calendarIdentifier: .chinese)
        let com = calendar?.components([.weekday], from: date)
        return numberToChina(weekNum: (com?.weekday)!)
    }
  
    // MARK: - 下个月
    static func nextMonth(date: Date = Date()) -> Date {
        let calendar = NSCalendar.current
        let nDate = calendar.date(byAdding: DateComponents(month: 1), to: date)
        return nDate!
    }
    
    // MARK: - 上个月
    static func lastMonth(date: Date = Date()) -> Date {
        let calendar = NSCalendar.current
        let lDate = calendar.date(byAdding: DateComponents(month: -1), to: date)
        return lDate!
    }
  
    // MARK: - 本月天数
    static func countOfDaysInCurrentMonth(date: Date = Date()) -> Int {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let range = (calendar as NSCalendar?)?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: date)
        return (range?.length)!
    }
 
    // MARK: - 当月第一天是星期几
    static func firstWeekDayInCurrentMonth(date: Date = Date()) -> Int {
        // 星期和数字一一对应 星期日：7
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        let date = dateFormatter.date(from: String(date.xj.year)+"-"+String(date.xj.month))
        let calender = Calendar(identifier: Calendar.Identifier.gregorian)
        let comps = (calender as NSCalendar?)?.components(NSCalendar.Unit.weekday, from: date!)
        var week = comps?.weekday
        if week == 1 {
            week = 8
        }
        return week! - 1
    }

    // MARK: - - 获取指定日期各种值
    // 根据年月得到某月天数
    static func getCountOfDaysInMonth(year: Int, month: Int) -> Int{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        let date = dateFormatter.date(from: String(year)+"-"+String(month))
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let range = (calendar as NSCalendar?)?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: date!)
        return (range?.length)!
    }
    
    // MARK: - 根据年月得到某月第一天是周几
    static func getfirstWeekDayInMonth(year: Int, month: Int) -> Int{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        let date = dateFormatter.date(from: String(year)+"-"+String(month))
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let comps = (calendar as NSCalendar?)?.components(NSCalendar.Unit.weekday, from: date!)
        let week = comps?.weekday
        return week! - 1
    }

    // MARK: - date转日期字符串
    static func dateToDateString(_ date: Date, dateFormat: String) -> String {
        let timeZone = NSTimeZone.local
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }

    // MARK: - 日期字符串转date
    static func dateStringToDate(_ dateStr: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateStr)
        return date!
    }
    
    // MARK: - 时间字符串转date
    static func timeStringToDate(_ dateStr: String) -> Date {
        let dateFormatter = DateFormatter()
        // dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateStr)
        return date!
    }

    // MARK: - 计算天数差
    static func dateDifference(_ dateA: Date, from dateB: Date) -> Double {
        let interval = dateA.timeIntervalSince(dateB)
        return interval/86400
    }

    // MARK: - 比较时间先后
    static func compareOneDay(oneDay: Date, withAnotherDay anotherDay: Date) -> Int {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let oneDayStr: String = dateFormatter.string(from: oneDay)
        let anotherDayStr: String = dateFormatter.string(from: anotherDay)
        let dateA = dateFormatter.date(from: oneDayStr)
        let dateB = dateFormatter.date(from: anotherDayStr)
        let result: ComparisonResult = (dateA?.compare(dateB!))!
        // Date1 is in the future
        if(result == ComparisonResult.orderedDescending ) {
            return 1
        }
        // Date1 is in the past
        else if(result == ComparisonResult.orderedAscending) {
            return 2
        }
            // Both dates are the same
        else {
            return 0
        }
    }

    // MARK: - 时间与时间戳之间的转化
    // 将时间转换为时间戳
    static func stringToTimeStamp(_ stringTime: String) -> Int {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = "yyyy-MM-dd HH: mm: ss"
        dfmatter.locale = Locale.current
        let date = dfmatter.date(from: stringTime)
        let dateStamp: TimeInterval = date!.timeIntervalSince1970
        let dateSt: Int = Int(dateStamp)
        return dateSt
    }
    
    // 将时间戳转换为年月日
    static func timeStampToString(_ timeStamp: String) -> String {
        let string = NSString(string: timeStamp)
        let timeSta: TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy年MM月dd日"
        let date = Date(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date)
    }
    
    // 将时间戳转换为具体时间
    static func timeStampToStringDetail(_ timeStamp: String) -> String {
        let string = NSString(string: timeStamp)
        let timeSta: TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy年MM月dd日HH: mm: ss"
        let date = Date(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date)
    }
    
    // 将时间戳转换为时分秒
    static func timeStampToHHMMSS(_ timeStamp: String) -> String {
        let string = NSString(string: timeStamp)
        let timeSta: TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="HH: mm: ss"
        let date = Date(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date)
    }
    
    // 获取系统的当前时间戳
    static func getStamp() -> Int{
        // 获取当前时间戳
        let date = Date()
        let timeInterval: Int = Int(date.timeIntervalSince1970)
        return timeInterval
    }
    
    // 日数字转汉字
    static func numberToChina(yearNum: Int) -> String {
        // 以一个天干和一个地支相配，排列起来，天干在前，地支在后，天干由甲起，地支由子起，阳干对阳支，阴干对阴支（阳干不配阴支，阴干不配阳支）
        // 就会得到六十年一周期的甲子回圈，一般称为“六十甲子”或“花甲子”
        // 十天干： 甲（jiǎ）、乙（yǐ）、丙（bǐng）、丁（dīng）、戊（wù）、己（jǐ）、庚（gēng）、辛（xīn）、壬（rén）、癸（guǐ）
        // 十二地支： 子（zǐ）、丑（chǒu）、寅（yín）、卯（mǎo）、辰（chén）、巳（sì）、午（wǔ）、未（wèi）、申（shēn）、酉（yǒu）、戌（xū）、亥（hài）
        let ChinaArray = [ "甲子", "乙丑", "丙寅", "丁卯", "戊辰", "己巳", "庚午", "辛未", "壬申", "癸酉",
                         "甲戌", "乙亥", "丙子", "丁丑", "戊寅", "己卯", "庚辰", "辛己", "壬午", "癸未",
                         "甲申", "乙酉", "丙戌", "丁亥", "戊子", "己丑", "庚寅", "辛卯", "壬辰", "癸巳",
                         "甲午", "乙未", "丙申", "丁酉", "戊戌", "己亥", "庚子", "辛丑", "壬寅", "癸丑",
                         "甲辰", "乙巳", "丙午", "丁未", "戊申", "己酉", "庚戌", "辛亥", "壬子", "癸丑",
                         "甲寅", "乙卯", "丙辰", "丁巳", "戊午", "己未", "庚申", "辛酉", "壬戌", "癸亥"]
        let ChinaStr: String = ChinaArray[yearNum - 1]
        return ChinaStr
    }
    
    // 月份数字转汉字
    static func numberToChina(monthNum: Int) -> String {
        let ChinaArray = ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"]
        let ChinaStr: String = ChinaArray[monthNum - 1]
        return ChinaStr
    }
    
    // 日数字转汉字
    static func numberToChina(dayNum: Int) -> String {
        let ChinaArray = [ "初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十",
                         "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十",
                         "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十"]
        let ChinaStr: String = ChinaArray[dayNum - 1]
        return ChinaStr
    }
      
    // 星期数字转汉字
    static func numberToChina(weekNum: Int) -> String {
        let ChinaArray = ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"]
        let ChinaStr: String = ChinaArray[weekNum - 1]
        return ChinaStr
    }
    
    // MARK: - 数字前补0
    static func add0BeforeNumber(_ number: Int) -> String {
        if number >= 10 {
            return String(number)
        }else{
            return "0" + String(number)
        }
    }

    // MARK: - 将时间显示为（几分钟前，几小时前，几天前）
    static func compareCurrentTime(str: String) -> String {

        let timeDate = self.timeStringToDate(str)
        let currentDate = NSDate()
        let timeInterval = currentDate.timeIntervalSince(timeDate)
        var temp: Double = 0
        var result: String = ""
        if timeInterval/60 < 1 {
            result = "刚刚"
        }else if (timeInterval/60) < 60{
            temp = timeInterval/60
            result = "\(Int(temp))分钟前"
        }else if timeInterval/60/60 < 24 {
            temp = timeInterval/60/60
            result = "\(Int(temp))小时前"
        }else if timeInterval/(24 * 60 * 60) < 30 {
            temp = timeInterval / (24 * 60 * 60)
            result = "\(Int(temp))天前"
        }else if timeInterval/(30 * 24 * 60 * 60) < 12 {
            temp = timeInterval/(30 * 24 * 60 * 60)
            result = "\(Int(temp))个月前"
        }else{
            temp = timeInterval/(12 * 30 * 24 * 60 * 60)
            result = "\(Int(temp))年前"
        }
        return result
    }
}
