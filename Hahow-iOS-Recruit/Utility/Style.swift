//
//  Style.swift
//  Hahow-iOS-Recruit
//
//  Created by Wilson on 2022/6/9.
//

import UIKit

enum Style {
    // 整體 app 間距設定
    static let lSpace: CGFloat = 15.0
    static let mSpace: CGFloat = 12.0
    static let sSpace: CGFloat = 10.0
}

// 自定義顏色及字體，方便整體套用及管理，g 代表 global，可以根據不同需求另外定義
extension UIColor {

    static let g_blackColor: UIColor = .black
    static let g_grayColor: UIColor = .gray
    static let g_backgroundColor: UIColor = .white
    static let g_lightGrayColor: UIColor = .lightGray
}

extension UIFont {

    static let g_xlFont: UIFont = .systemFont(ofSize: 20)
    static let g_lFont: UIFont = .systemFont(ofSize: 15)
    static let g_mFont: UIFont = .systemFont(ofSize: 13)
}
