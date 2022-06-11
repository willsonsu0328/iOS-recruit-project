//
//  CourseHomeBigCollectionViewCell.swift
//  Hahow-iOS-Recruit
//
//  Created by Wilson on 2022/6/11.
//

import UIKit
import SDWebImage

class CourseHomeBigCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "CourseHomeBigCell"
    static func register(for collectionView: UICollectionView) {
        collectionView.register(UINib.init(nibName: "CourseHomeBigCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: reuseIdentifier)
    }

    var course: CourseModel? {
        didSet {
            renderView()
        }
    }

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        setupView()
    }

    func setupView() {
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15.0

        titleLabel.font = .g_lFont
        titleLabel.textColor = .g_blackColor
        titleLabel.numberOfLines = 2
        titleLabel.text = " "

        detailLabel.font = .g_mFont
        detailLabel.textColor = .g_grayColor
        detailLabel.numberOfLines = 1
        detailLabel.text = " "
    }

    func renderView() {
        guard let course = course else { return }
        imageView.sd_setImage(with: course.coverImageURL)
        titleLabel.text = course.title
        detailLabel.text = course.name
    }

}
