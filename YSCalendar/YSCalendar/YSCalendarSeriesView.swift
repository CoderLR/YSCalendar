//
//  YSCalendarSeriesView.swift
//  XJSwiftKit
//
//  Created by xj on 2021/11/2.
//

import UIKit

// MARK: -  日历控件-连续
class YSCalendarSeriesView: UICollectionViewCell {
    
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
    
    /// 星期
    fileprivate lazy var weekView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 30, width: self.width, height: 20))
        view.backgroundColor = Color_System
        return view
    }()
    
    /// collectionView
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: CGRect(x: 0, y: 50, width: self.width, height: self.height - 50), collectionViewLayout: layout)
        collection.backgroundColor = UIColor.white
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.register(YSDaySeriesCell.self, forCellWithReuseIdentifier: "YSDaySeriesCell")
        return collection
    }()

    /// 数据源
    fileprivate var dayModels: [YSDayModel?] = YSDayModel.getDateList()
    
    /// 星期数组
    fileprivate var chineseWeeks: [String] = ["日", "一", "二", "三", "四", "五", "六"]
        
    /// 滚动索引
    var selectedIndex: Int = 0
    var velocityY: CGFloat = 0
    
    /// 日期回调
    var dateSelectChangeBlock: ((YSDayModel) -> ())?
    
    /// 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.layer.borderColor = Color_System.cgColor
        self.layer.borderWidth = 0.5
        
        self.addSubview(collectionView)
        self.addSubview(weekView)
        self.addSubview(dateLabel)
        
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
        
        collectionView.scrollToItem(at: KCurrentIndexPath, at: .top, animated: false)
        
        selectedIndex = Int(KCurrentIndexPath.item / KCalendarColum)
        print("selectedIndex =  \(selectedIndex)" )
        
        // 设置时间显示
        refreshDateLabel()
    }
    
    /// 更新显示
    func refreshDateLabel(_ dayModel: YSDayModel? = nil) {
        if let model = dayModel {
            dateLabel.text = "\(model.year)年\(model.month)月"
        } else {
            dateLabel.text = "\(YSCalendarConfig.currentYear)年\(YSCalendarConfig.currentMonth)月"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("YSCalendarSeriesView-delloc")
        YSCalendarConfig.resetCurrentDate()
    }
}

// MARK: - UIScrollViewDelegate
extension YSCalendarSeriesView: UIScrollViewDelegate {
    
    /// 用户即将停止拖拽
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let y = targetContentOffset.pointee.y
        
        // 滚动高度
        let pageHeight = KCalendarDayCellH + KCalendarMarginV

        // 通过selectedIndex的值，将要停下来的坐标y,计算位移
        let moveindex = y - pageHeight * CGFloat(selectedIndex)

        // 当位移绝对值大于分页宽度的一半时,滚动到位移方向的相邻页
        if moveindex < -pageHeight * 0.5 {
            selectedIndex -= 1
        } else if moveindex > pageHeight * 0.5 {
            selectedIndex += 1
        }
        
        print("selectedIndex = \(selectedIndex)---\(velocity)")
        velocityY = abs(velocity.y)
        if velocityY >= 1.0 {
            targetContentOffset.pointee.y = pageHeight * CGFloat(selectedIndex)
        } else {
            targetContentOffset.pointee.y = scrollView.contentOffset.y
            scrollView.setContentOffset(CGPoint(x: 0, y: pageHeight * CGFloat(selectedIndex)), animated: true)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollViewDidEndDragging")
//        if velocityY < 1.0 {
//            let dayModel = self.dayModels[KCalendarColum * selectedIndex + 3]
//            refreshDateLabel(dayModel)
//            return
//        }
//        // 滚动高度
//        let pageHeight = KCalendarDayCellH + KCalendarMarginV
//        selectedIndex = Int(scrollView.contentOffset.y / pageHeight)
//        scrollView.setContentOffset(CGPoint(x: 0, y: pageHeight * CGFloat(selectedIndex)), animated: true)
//
//        let dayModel = self.dayModels[KCalendarColum * selectedIndex + 3]
//        refreshDateLabel(dayModel)
    }
}

// MARK: - UICollectionViewDelegate
extension YSCalendarSeriesView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // 返回cell个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dayModels.count
    }
    
    // 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YSDaySeriesCell", for: indexPath) as! YSDaySeriesCell
        cell.indexPath = indexPath
        cell.dayModel = dayModels[indexPath.item]
        return cell
    }
    
    // 点击cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   
        // 空白
        guard let dayModel = self.dayModels[indexPath.item] else { return }
        
        // 全局唯一
        KCurrentIndexPath = indexPath
        
        // 全局唯一
        YSCalendarConfig.setCurrentDate(dayModel)
        
        // 刷新
        CATransaction.setDisableActions(true)
        collectionView.reloadData()
        CATransaction.commit()
        
        YSCalendarConfig.dayModel = dayModel
        if let dateSelectChangeBlock = dateSelectChangeBlock {
            dateSelectChangeBlock(YSCalendarConfig.dayModel)
        }
    }
    
    // 定义每个Cell的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: KCalendarDayCellH, height: KCalendarDayCellH)
    }
    
    // 定义每个Section的四边间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: KCalendarMarginV, left: KCalendarMarginH, bottom: KCalendarMarginV, right: KCalendarMarginH)
    }
    
    // 这个是两行cell之间的间距（上下行cell的间距）
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return KCalendarMarginV
    }
    
    // 两个cell之间的间距（同一行的cell的间距）
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return KCalendarMarginH
    }
}
