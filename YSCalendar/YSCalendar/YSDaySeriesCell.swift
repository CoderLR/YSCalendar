//
//  YSDaySeriesCell.swift
//  XJSwiftKit
//
//  Created by xj on 2021/11/1.
//

import UIKit

// MARK: - 每一天
class YSDaySeriesCell: UICollectionViewCell {

    fileprivate var dayLabel: UILabel!        // 公历
    fileprivate var dayChineseLabel: UILabel! // 农历
    var selectView: UIView!                   // 选中
    
    var dayModel: YSDayModel? {
        didSet {
            if let model = dayModel {
                
                if model.day == 1 {
                    dayLabel.text = "\(model.month)月"
                } else {
                    dayLabel.text = "\(model.day)"
                }
                
                if model.chineseDay == "初一" {
                    dayChineseLabel.text = model.chineseMonth
                } else {
                    dayChineseLabel.text = model.chineseDay
                }
                
                // 当前天颜色
                if YSCalendarConfig.isCurrentDate(model) &&
                    KCurrentIndexPath == self.indexPath {
                    
                    selectView.isHidden = false
                    dayLabel.textColor = UIColor.white
                    dayChineseLabel.textColor = UIColor.white
                } else {
                    selectView.isHidden = true
                    
                    // 周末颜色
                    if model.week == 1 || model.week == 7 {
                        dayLabel.textColor = Color_999999_999999
                        dayChineseLabel.textColor = Color_999999_999999
                    } else {
                        dayLabel.textColor = Color_333333_333333
                        dayChineseLabel.textColor = Color_333333_333333
                    }
                }
                          
            } else {
                dayLabel.text = ""
                dayChineseLabel.text = ""
            }
        }
    }
    
    /// 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        selectView = UIView.xj.create(bgColor: Color_System, cornerRadius: (KCalendarDayCellH - 10) * 0.5)
        selectView.isHidden = true
        self.contentView.addSubview(selectView)
        
        dayLabel = UILabel.xj.create(bgColor: UIColor.clear,
                          text: "",
                          textColor: Color_333333_333333,
                          font: 15,
                          textAlignment: .center,
                          numberOfLines: 1)
        self.contentView.addSubview(dayLabel)
        
        dayChineseLabel = UILabel.xj.create(bgColor: UIColor.clear,
                          text: "",
                          textColor: Color_333333_333333,
                          font: 12,
                          textAlignment: .center,
                          numberOfLines: 1)
        self.contentView.addSubview(dayChineseLabel)
        
        selectView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        }
        
        dayLabel.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 40, height: 20))
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-8)
        }
        
        dayChineseLabel.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 40, height: 20))
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(8)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
