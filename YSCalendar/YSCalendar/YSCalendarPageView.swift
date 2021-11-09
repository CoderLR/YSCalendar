//
//   YSCalendarPageView.swift
//  XJSwiftKit
//
//  Created by xj on 2021/11/1.
//

import UIKit
import SnapKit

// MARK: -  日历控件-翻页
class  YSCalendarPageView: UIView {
    
    /// 日期
    fileprivate lazy var dateLabel: UILabel = {
        let label = UILabel.xj.create(bgColor: UIColor.clear,
                                      text: "2021-11-01",
                                      textColor: Color_333333_333333,
                                      font: 15,
                                      textAlignment: .center,
                                      numberOfLines: 1)
        return label
    }()
    
    /// 上月
    fileprivate lazy var lastBtn: UIButton = {
        let button = UIButton.xj.create(bgColor: UIColor.clear, imageName: "icon_calendar_last")
        button.addTarget(self, action: #selector(lastBtnClick(_:)), for: .touchUpInside)
        return button
    }()
    
    /// 下月
    fileprivate lazy var nextBtn: UIButton = {
        let button = UIButton.xj.create(bgColor: UIColor.clear, imageName: "icon_calendar_next")
        button.addTarget(self, action: #selector(nextBtnClick(_:)), for: .touchUpInside)
        return button
    }()
    
    /// 星期
    fileprivate lazy var weekView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 30, width: self.width, height: 20))
        view.backgroundColor = Color_System
        return view
    }()
    
    /// collectionView
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: CGRect(x: 0, y: 50, width: self.width, height: self.height - 50), collectionViewLayout: layout)
        collection.backgroundColor = UIColor.white
        collection.delegate = self
        collection.dataSource = self
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.bounces = false
        collection.register(YSCalendarCell.self, forCellWithReuseIdentifier: "YSCalendarCell")
        return collection
    }()
    
    /// 数据源
    fileprivate var monthModels: [[YSDayModel?]] = YSDayModel.getDatePageList()
    
    /// 星期数组
    fileprivate var chineseWeeks: [String] = ["日", "一", "二", "三", "四", "五", "六"]
    
    /// 滚动到当月
    fileprivate var nowIndexPath: IndexPath = IndexPath.init(item: 0, section: 0)
    
    /// 偏移量-判断滚动方向
    fileprivate var lastOffsetX: CGFloat = 0
    
    /// 日期回调
    var dateSelectChangeBlock: ((YSDayModel) -> ())?

    /// 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.layer.borderColor = Color_System.cgColor
        self.layer.borderWidth = 0.5
        
        self.nowIndexPath = KCurrentPageIndexPath
        
        self.addSubview(dateLabel)
        self.addSubview(lastBtn)
        self.addSubview(nextBtn)
        self.addSubview(weekView)
        self.addSubview(collectionView)
        
        for i in 0..<chineseWeeks.count {
            let weekLabel = UILabel.xj.create(bgColor: UIColor.clear,
                              text: chineseWeeks[i],
                              textColor: Color_333333_333333,
                              font: 13,
                              textAlignment: .center,
                              numberOfLines: 1)
            weekLabel.size = CGSize(width: KCalendarDayCellH, height: 20)
            weekLabel.x = KCalendarMarginH + (KCalendarDayCellH + KCalendarMarginH) * CGFloat(i)
            weekView.addSubview(weekLabel)
        }
    
        dateLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(15)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: self.width * 0.5, height: 30))
        }
        lastBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(15)
            make.right.equalTo(dateLabel.snp.left).offset(-10)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        nextBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(15)
            make.left.equalTo(dateLabel.snp.right).offset(10)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        // 滚动到当前月份
        collectionView.scrollToItem(at: KCurrentPageIndexPath, at: .left, animated: false)
        
        // 更新时间
        refreshDateLabel()
    }
    
    /// 更新显示
    func refreshDateLabel() {
        dateLabel.text = "\(YSCalendarConfig.currentYear)-\(YSCalendarConfig.currentMonth)-\(YSCalendarConfig.currentDay)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("YSCalendarPageView-delloc")
        YSCalendarConfig.resetCurrentDate()
    }
}

// MARK: - Action
extension YSCalendarPageView {
    
    /// 上一步按钮点击
    @objc func lastBtnClick(_ button: UIButton?) {
        
        if nowIndexPath.item - 1 < 0 { return }
        
        // 设置上个月
        let date = YSDateTool.dateStringToDate("\(YSCalendarConfig.currentYear)-\(YSCalendarConfig.currentMonth)-\(YSCalendarConfig.currentDay)")
        let lastDate = YSDateTool.lastMonth(date: date)
        // 上月天数
        let maxDay = YSDateTool.countOfDaysInCurrentMonth(date: lastDate)
        let lastDay = YSCalendarConfig.currentDay > maxDay ? maxDay : YSCalendarConfig.currentDay
        let dayModel = YSDayModel.getDayModel(date: lastDate, index: lastDay - 1, dayType: .current)
        YSCalendarConfig.setCurrentDate(year: dayModel.year, month: dayModel.month, day: dayModel.day)
        YSCalendarConfig.dayModel = dayModel
        
        // 更新时间
        refreshDateLabel()
        
        scrollToLast(isScroll: (button == nil ? false : true))
    }
    
    /// 下一步按钮点击
    @objc func nextBtnClick(_ button: UIButton?) {
        
        if nowIndexPath.item + 1 >= monthModels.count { return }
        
        // 设置下个月
        let date = YSDateTool.dateStringToDate("\(YSCalendarConfig.currentYear)-\(YSCalendarConfig.currentMonth)-\(YSCalendarConfig.currentDay)")
        let nextDate = YSDateTool.nextMonth(date: date)
        
        // 下月天数
        let maxDay = YSDateTool.countOfDaysInCurrentMonth(date: nextDate)
        let nextDay = YSCalendarConfig.currentDay > maxDay ? maxDay : YSCalendarConfig.currentDay
        let dayModel = YSDayModel.getDayModel(date: nextDate, index: nextDay - 1, dayType: .current)
        YSCalendarConfig.setCurrentDate(year: dayModel.year, month: dayModel.month, day: dayModel.day)
        YSCalendarConfig.dayModel = dayModel
        
        // 更新时间
        refreshDateLabel()
        
        scrollToNext(isScroll: (button == nil ? false : true))
    }
    
    /// 向左滚动
    func scrollToLast(_ dayModel: YSDayModel? = nil, isScroll: Bool = true) {
        if nowIndexPath.item - 1 < 0 { return }
        
        nowIndexPath = IndexPath.init(item: nowIndexPath.item - 1, section: 0)
        if isScroll {
            collectionView.scrollToItem(at: nowIndexPath, at: .left, animated: true)
        }
        // 全局唯一
        KCurrentPageIndexPath = nowIndexPath
        KCurrentIndexPath = YSDayModel.getIndexPath(self.monthModels)
        
        CATransaction.setDisableActions(true)
        collectionView.reloadData()
        CATransaction.commit()
        
        // 日期回调
        if let dateSelectChangeBlock = dateSelectChangeBlock {
            dateSelectChangeBlock(YSCalendarConfig.dayModel)
        }
    }
    
    /// 向右滚动
    func scrollToNext(_ dayModel: YSDayModel? = nil, isScroll: Bool = true) {
        if nowIndexPath.item + 1 >= monthModels.count { return }
        
        nowIndexPath = IndexPath.init(item: nowIndexPath.item + 1, section: 0)
        if isScroll {
            collectionView.scrollToItem(at: nowIndexPath, at: .right, animated: true)
        }
    
        // 全局唯一
        KCurrentPageIndexPath = nowIndexPath
        KCurrentIndexPath = YSDayModel.getIndexPath(self.monthModels)
        
        CATransaction.setDisableActions(true)
        collectionView.reloadData()
        CATransaction.commit()
        
        // 日期回调
        if let dateSelectChangeBlock = dateSelectChangeBlock {
            dateSelectChangeBlock(YSCalendarConfig.dayModel)
        }
    }
}

// MARK: - UIScrollViewDelegate
extension YSCalendarPageView: UIScrollViewDelegate {
    
    /// 开始拖拽
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastOffsetX = scrollView.contentOffset.x
    }

    /// 结束减速
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        // 向右滑动
        if scrollView.contentOffset.x > lastOffsetX {
           
            self.nextBtnClick(nil)
        // 向左滑动
        } else if scrollView.contentOffset.x < lastOffsetX {
            self.lastBtnClick(nil)
        }
        
        // 更新lastOffsetX
        lastOffsetX = scrollView.contentOffset.x
    }
}

// MARK: - UICollectionViewDelegate
extension YSCalendarPageView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // 返回cell个数 1970~至今~未来
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return monthModels.count
    }
    
    // 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YSCalendarCell", for: indexPath) as! YSCalendarCell
        let dayModels = self.monthModels[indexPath.item]
        cell.pageIndexPath = indexPath
        cell.dayModels = dayModels
        
        cell.clickCellBlock = {[weak self] (dayModel) in
            guard let self = self else { return }
            YSCalendarConfig.dayModel = dayModel
            if dayModel.dayType == .last {
                self.scrollToLast(dayModel)
            } else if dayModel.dayType == .next {
                self.scrollToNext(dayModel)
            } else if dayModel.dayType == .current {
                self.refreshDateLabel()
                // 日期回调
                if let dateSelectChangeBlock = self.dateSelectChangeBlock {
                    dateSelectChangeBlock(YSCalendarConfig.dayModel)
                }
            }
        }
        return cell
    }

    // 定义每个Cell的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.width, height: self.height - 50)
    }
    
    // 定义每个Section的四边间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // 这个是两行cell之间的间距（上下行cell的间距）
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 两个cell之间的间距（同一行的cell的间距）
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


