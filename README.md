# 日历控件
能显示阳历和阴历的日历控件

# 显示效果
![日历控件](https://img2020.cnblogs.com/blog/775305/202111/775305-20211109110512287-548004417.gif)  

# 使用方式
    /// 翻页-日历  
    fileprivate lazy var calendarPageView: YSCalendarPageView = {  
        let calendar = YSCalendarPageView(frame: CGRect(x: 20, y: KNavBarH, width: KCalendarViewW, height: KCalendarPageViewH))  
        return calendar  
    }()  
    
    calendarPageView.dateSelectChangeBlock = { model in  
        print("------------翻页-日历-------------")  
        print("------------\(model.year)-\(model.month)-\(model.day)-------------")  
        print("------------\(model.chineseYear)-\(model.chineseMonth)-\(model.chineseDay)-------------")  
    }  
