//
//  CourseHomeViewController.swift
//  Hahow-iOS-Recruit
//
//  Created by Wilson on 2022/6/9.
//

import UIKit
import ReactiveSwift
import PureLayout

class CourseHomeViewController: BaseViewController {

    // iPhone layout
    lazy var collectionViewIPhoneLayout: UICollectionViewLayout = {
        let bigItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(370.0))
        let bigItem = NSCollectionLayoutItem(layoutSize: bigItemSize)

        let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(90.0))
        let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [bigItem, smallItem, smallItem])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(Style.mSpace)

        let section = NSCollectionLayoutSection(group: group)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        section.contentInsets = .init(top: 0, leading: Style.lSpace, bottom: Style.lSpace, trailing: Style.lSpace)
        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }()

    // IPad size class 為 Regular 的 layout
    var collectionViewIPadRegularLayout: UICollectionViewLayout {
        let viewWidth: CGFloat = view.bounds.width
        let itemWidth: CGFloat = viewWidth / 2 - Style.lSpace
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(itemWidth), heightDimension: .absolute(90.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(viewWidth), heightDimension: .estimated(180.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item, item, item])
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: NSCollectionLayoutSpacing.fixed(0.0), top: NSCollectionLayoutSpacing.fixed(0.0), trailing: NSCollectionLayoutSpacing.fixed(0.0), bottom: NSCollectionLayoutSpacing.fixed(Style.sSpace))

        let section = NSCollectionLayoutSection(group: group)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        section.contentInsets = .init(top: 0, leading: Style.lSpace, bottom: Style.lSpace, trailing: Style.lSpace)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    // IPad size class 為 Compact 的 layout
    var collectionViewIPadCompactLayout: UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(90.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(90.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

        section.interGroupSpacing = Style.mSpace

        section.boundarySupplementaryItems = [header]
        section.contentInsets = .init(top: 0, leading: Style.lSpace, bottom: Style.lSpace, trailing: Style.lSpace)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    lazy var collectionView: UICollectionView = {

        // 根據裝置設定初始 layout
        var collectionViewLayout: UICollectionViewLayout = collectionViewIPhoneLayout
        switch courseHomeViewModel.currentDeviceModel {
        case .phone:
            collectionViewLayout = collectionViewIPhoneLayout
        case .pad:
            collectionViewLayout = collectionViewIPadRegularLayout
        default:
            break
        }
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .g_backgroundColor
        collectionView.dataSource = self

        CourseHomeBigCollectionViewCell.register(for: collectionView)
        CourseHomeSmallCollectionViewCell.register(for: collectionView)
        BaseCollectionReusableHeaderView.register(for: collectionView)

        view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()

        return collectionView
    }()

    var courseHomeViewModel = CourseHomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("coursehome_title", comment: "")
        refreshContent()
    }

    func refreshContent() {
        courseHomeViewModel.refreshContentSignal.start(Signal<CourseHomeViewModel, Error>.Observer(failed: { [weak self] error in
            guard let self = self else { return }
            let errorAlert = UIAlertController(title: NSLocalizedString("coursehome_erroralerttitle", comment: ""), message: error.localizedDescription, preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: NSLocalizedString("coursehome_erroralertaction", comment: ""), style: .default))
            self.navigationController?.present(errorAlert, animated: true, completion: nil)
        }, completed: {
            self.collectionView.reloadData()
        }))
    }

    // MARK: Super Method

    // 處理畫面旋轉、及分割畫面
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { [weak self] _ in
            guard let self = self else { return }
            if self.traitCollection.horizontalSizeClass == .compact {
                self.collectionView.setCollectionViewLayout(self.collectionViewIPadCompactLayout, animated: true)
            } else {
                self.collectionView.setCollectionViewLayout(self.collectionViewIPadRegularLayout, animated: true)
            }
        }
    }

}

extension CourseHomeViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        courseHomeViewModel.filteredCategoryModel.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        courseHomeViewModel.filteredCategoryModel[section].filterCourses.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let categoryModel = courseHomeViewModel.filteredCategoryModel[indexPath.section]

        if courseHomeViewModel.cellType(for: indexPath) == .bigCell, let bigCell = collectionView.dequeueReusableCell(withReuseIdentifier: CourseHomeBigCollectionViewCell.reuseIdentifier, for: indexPath) as? CourseHomeBigCollectionViewCell {

            bigCell.course = categoryModel.filterCourses[indexPath.item]
            return bigCell

        } else if courseHomeViewModel.cellType(for: indexPath) == .smallCell, let smallCell = collectionView.dequeueReusableCell(withReuseIdentifier: CourseHomeSmallCollectionViewCell.reuseIdentifier, for: indexPath) as? CourseHomeSmallCollectionViewCell {

            smallCell.course = categoryModel.filterCourses[indexPath.item]

            return smallCell
        }

        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if kind == UICollectionView.elementKindSectionHeader, let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BaseCollectionReusableHeaderView.reuseIdentifier, for: indexPath) as? BaseCollectionReusableHeaderView {
            headerView.title = courseHomeViewModel.filteredCategoryModel[indexPath.section].categoryType.title
            return headerView
        }
        return UICollectionReusableView()

    }

}
