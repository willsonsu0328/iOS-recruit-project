//
//  UIImageViewExtension.swift
//  Hahow-iOS-Recruit
//
//  Created by Wilson on 2022/6/12.
//

import SDWebImage

extension UIImageView {

    func setImage(url: URL?, placeholderImage: UIImage?) {
        sd_setImage(with: url, placeholderImage: placeholderImage)
    }

    func setImageURLWithDefaultPlaceholderImage(url: URL?) {
        let placeholderImage = UIImage().createImage(color: .g_lightGrayColor)
        setImage(url: url, placeholderImage: placeholderImage)
    }

}
