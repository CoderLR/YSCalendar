//
//  XJExtension.swift
//  XJSwiftKit
//
//  Created by Mr.Yang on 2021/10/20.
//

import UIKit

public struct XJExtension<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

public protocol XJCompatible {}

public extension XJCompatible {
    
    static var xj: XJExtension<Self>.Type {
        get{ XJExtension<Self>.self }
        set {}
    }
    
    var xj: XJExtension<Self> {
        get { XJExtension(self) }
        set {}
    }
}
