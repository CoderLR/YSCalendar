//
//  YSCalendarCell.swift
//  XJSwiftKit
//
//  Created by xj on 2021/11/1.
//

import UIKit

// MARK: -  日历控件
class YSCalendarCell: UICollectionViewCell {
    
    /// collectionView
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.white
        collection.delegate = self
        collection.dataSource = self
        collection.register(YSDayPageCell.self, forCellWithReuseIdentifier: "YSDayPageCell")
        return collection
    }()

    /// 数据源
    var dayModels: [YSDayModel?] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    /// 点击事件回调
    var clickCellBlock: ((YSDayModel) -> ())?
    
    /// 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDelegate
extension YSCalendarCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // 返回cell个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dayModels.count
    }
    
    // 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YSDayPageCell", for: indexPath) as! YSDayPageCell
        cell.indexPath = indexPath
        cell.pageIndexPath = self.pageIndexPath
        cell.dayModel = dayModels[indexPath.item]
        return cell
    }
    
    // 点击cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 数据空
        guard let dayModel = self.dayModels[indexPath.item] else { return }
        
        // 全局唯一
        KCurrentIndexPath = indexPath
        
        // 全局唯一
        YSCalendarConfig.setCurrentDate(dayModel)
        
        // 刷新
        CATransaction.setDisableActions(true)
        collectionView.reloadData()
        CATransaction.commit()
        
        // 点击回调
        if let clickCellBlock = clickCellBlock {
            clickCellBlock(dayModel)
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
