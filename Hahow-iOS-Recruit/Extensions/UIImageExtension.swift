//
//  UIImageExtension.swift
//  Hahow-iOS-Recruit
//
//  Created by Wilson on 2022/6/12.
//

import Foundation
import UIKit

extension UIImage {

    func createImage(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContext(rect.size)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else { return nil }
        return UIImage(cgImage: cgImage)
    }

}
