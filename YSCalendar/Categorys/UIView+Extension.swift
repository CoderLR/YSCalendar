//
//  UIView+Extension.swift
//  XJSwiftKit
//
//  Created by Mr.Yang on 2021/10/13.
//

import UIKit

extension UIView: XJCompatible {}

// MARK: - Create
public extension XJExtension where Base: UIView {

    /// UIView创建
    /// - Parameters: - bgColor: 背景颜色
    /// - Returns: UIView
    static func create(bgColor: UIColor = UIColor.white,
                    cornerRadius: CGFloat? = nil,
                    borderColor: UIColor? = nil,
                    borderWidth: CGFloat? = nil) -> Base {
        let view = Base()
        view.backgroundColor = bgColor
        if let cornerRadius = cornerRadius {
            view.layer.cornerRadius = cornerRadius
            view.layer.masksToBounds = true
        }
        if let borderColor = borderColor {
            view.layer.borderColor = borderColor.cgColor
        }
        if let borderWidth = borderWidth {
            view.layer.borderWidth = borderWidth
        }
        return view
    }
    
    
    /// 设置圆角和边框
    /// - Parameters:
    ///   - cornerRadius: 圆角半径
    ///   - borderColor: 边框颜色
    ///   - borderWidth: 边框宽度
    /// - Returns: view
    @discardableResult
    func setLayer(cornerRadius: CGFloat? = nil,
                    borderColor: UIColor? = nil,
                    borderWidth: CGFloat? = nil) -> Base {
        if let cornerRadius = cornerRadius {
            self.base.layer.cornerRadius = cornerRadius
            self.base.layer.masksToBounds = true
        }
        if let borderColor = borderColor {
            self.base.layer.borderColor = borderColor.cgColor
        }
        if let borderWidth = borderWidth {
            self.base.layer.borderWidth = borderWidth
        }
        return self.base
    }
}

// MARK:- 六、自定义链式编程
public extension UIView {
    // MARK: 6.1、设置 tag 值
    /// 设置 tag 值
    /// - Parameter tag: 值
    /// - Returns: 返回自身
    @discardableResult
    func tag(_ tag: Int) -> Self {
        self.tag = tag
        return self
    }
    
    // MARK: 6.2、设置圆角
    /// 设置圆角
    /// - Parameter cornerRadius: 圆角
    /// - Returns: 返回自身
    @discardableResult
    func corner(_ cornerRadius: CGFloat) -> Self {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        return self
    }
    
    // MARK: 6.3、图片的模式
    /// 图片的模式
    /// - Parameter mode: 模式
    /// - Returns: 返回图片的模式
    @discardableResult
    func contentMode(_ mode: UIView.ContentMode) -> Self {
        contentMode = mode
        return self
    }
    
    // MARK: 6.4、设置背景色
    /// 设置背景色
    /// - Parameter color: 颜色
    /// - Returns: 返回自身
    @discardableResult
    func backgroundColor(_ color: UIColor) -> Self {
        backgroundColor = color
        return self
    }
    
    // MARK: 6.6、设置 frame
    /// 设置 frame
    /// - Parameter frame: frame
    /// - Returns: 返回自身
    @discardableResult
    func frame(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }
    
    // MARK: 6.7、被添加到某个视图上
    /// 被添加到某个视图上
    /// - Parameter superView: 父视图
    /// - Returns: 返回自身
    @discardableResult
    func addTo(_ superView: UIView) -> Self {
        superView.addSubview(self)
        return self
    }
    
    // MARK: 6.8、设置是否支持触摸
    /// 设置是否支持触摸
    /// - Parameter isUserInteractionEnabled: 是否支持触摸
    /// - Returns: 返回自身
    @discardableResult
    func isUserInteractionEnabled(_ isUserInteractionEnabled: Bool) -> Self {
        self.isUserInteractionEnabled = isUserInteractionEnabled
        return self
    }
    
    // MARK: 6.9、设置是否隐藏
    /// 设置是否隐藏
    /// - Parameter isHidden: 是否隐藏
    /// - Returns: 返回自身
    @discardableResult
    func isHidden(_ isHidden: Bool) -> Self {
        self.isHidden = isHidden
        return self
    }
    
    // MARK: 6.10、设置透明度
    /// 设置透明度
    /// - Parameter alpha: 透明度
    /// - Returns: 返回自身
    @discardableResult
    func alpha(_ alpha: CGFloat) -> Self {
        self.alpha = alpha
        return self
    }
    
    // MARK: 6.11、设置tintColor
    /// 设置tintColor
    /// - Parameter tintColor: tintColor description
    /// - Returns: 返回自身
    @discardableResult
    func tintColor(_ tintColor: UIColor) -> Self {
        self.tintColor = tintColor
        return self
    }
}

// MARK: - 坐标
extension UIView {
    
    /// 横坐标
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newValue) {
            var rect = self.frame
            rect.origin.x = newValue
            self.frame = rect
        }
    }
    
    /// 纵坐标
    var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set(newValue) {
            var rect = self.frame
            rect.origin.y = newValue
            self.frame = rect
        }
    }
    
    /// 顶端间距
    var top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set(newValue) {
            var rect = self.frame
            rect.origin.y = newValue
            self.frame = rect
        }
    }
    
    /// 底端间距
    var bottom: CGFloat {
        get {
            return (self.frame.origin.y + self.frame.size.height)
        }
        set(newValue) {
            var rect = self.frame
            rect.origin.y = (newValue - self.frame.size.height)
            self.frame = rect
        }
    }
    
    /// 宽度
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set(newValue) {
            var rect = self.frame
            rect.size.width = newValue
            self.frame = rect
        }
    }
    
    /// 高度
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set(newValue)
        {
            var rect = self.frame
            rect.size.height = newValue
            self.frame = rect
        }
    }
    
    /// Size
    var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            var rect = self.frame
            rect.size = newValue
            self.frame = rect
        }
    }
    
    /// centerX
    var centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    
    /// centerY
    var centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }
}
