//
//  BaseCollectionReusableTitleView.swift
//  Hahow-iOS-Recruit
//
//  Created by Wilson on 2022/6/11.
//

import UIKit
import PureLayout

class BaseCollectionReusableHeaderView: UICollectionReusableView {

    static let reuseIdentifier = "BaseCollectionReusableHeaderView"
    static func register(for collectionView: UICollectionView) {
        collectionView.register(BaseCollectionReusableHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseIdentifier)
    }

    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }

    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    func setupView() {
        titleLabel.font = .g_xlFont
        titleLabel.textColor = .g_blackColor
        titleLabel.text = " "

        addSubview(titleLabel)
        titleLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: Style.lSpace, left: Style.lSpace, bottom: Style.mSpace, right: Style.lSpace))
    }
}
