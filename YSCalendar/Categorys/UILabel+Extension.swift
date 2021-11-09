//
//  UILabel+Extension.swift
//  XJSwiftKit
//
//  Created by Mr.Yang on 2021/10/14.
//

import UIKit

// MARK: - Create
public extension XJExtension where Base: UILabel {
        
    /// UILabel创建
    /// - Parameters:
    ///   - bgColor: 背景颜色
    ///   - text: 显示内容
    ///   - textColor: 文字颜色
    ///   - font: 文字大小
    ///   - textAlignment: 居中、偏左、偏右
    ///   - numberOfLines: 多行显示
    /// - Returns: UILabel
    static func create(bgColor: UIColor = UIColor.white,
                     text: String = "",
                     textColor: UIColor,
                     font: CGFloat = 16,
                     textAlignment: NSTextAlignment = .center,
                     numberOfLines: Int = 0) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: font)
        label.textColor = textColor
        label.backgroundColor = bgColor
        label.text = text
        label.textAlignment = textAlignment
        label.numberOfLines = numberOfLines
        return label
    }
}

// MARK:- 一、链式编程
public extension UILabel {
    
    // MARK: 1.1、设置文字
    /// 设置文字
    /// - Parameter text: 文字内容
    /// - Returns: 返回自身
    @discardableResult
    func text(_ text: String) -> Self {
        self.text = text
        return self
    }
    
    // MARK: 1.2、设置文字行数
    /// 设置文字行数
    /// - Parameter number: 行数
    /// - Returns: 返回自身
    @discardableResult
    func line(_ number: Int) -> Self {
        numberOfLines = number
        return self
    }
    
    // MARK: 1.3、设置文字对齐方式
    /// 设置文字对齐方式
    /// - Parameter alignment: 对齐方式
    /// - Returns: 返回自身
    @discardableResult
    func textAlignment(_ alignment: NSTextAlignment) -> Self {
        textAlignment = alignment
        return self
    }
    
    // MARK: 1.4、设置富文本文字
    /// 设置富文本文字
    /// - Parameter attributedText: 富文本文字
    /// - Returns: 返回自身
    @discardableResult
    func attributedText(_ attributedText: NSAttributedString) -> Self {
        self.attributedText = attributedText
        return self
    }
    
    // MARK: 1.5、设置文本颜色
    /// 设置文本颜色
    /// - Parameter color: 颜色
    /// - Returns:  返回自身
    @discardableResult
    func color(_ color: UIColor) -> Self {
        textColor = color
        return self
    }
    
    // MARK: 1.7、设置字体的大小
    /// 设置字体的大小
    /// - Parameter font: 字体的大小
    /// - Returns: 返回自身
    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    // MARK: 1.8、设置字体的大小
    /// 设置字体的大小
    /// - Parameter fontSize: 字体的大小
    /// - Returns: 返回自身
    @discardableResult
    func font(_ fontSize: CGFloat) -> Self {
        font = UIFont.systemFont(ofSize: fontSize)
        return self
    }
    
    // MARK: 1.9、设置字体的大小（粗体）
    /// 设置字体的大小（粗体）
    /// - Parameter fontSize: 字体的大小
    /// - Returns: 返回自身
    @discardableResult
    func boldFont(_ fontSize: CGFloat) -> Self {
        font = UIFont.boldSystemFont(ofSize: fontSize)
        return self
    }
}
