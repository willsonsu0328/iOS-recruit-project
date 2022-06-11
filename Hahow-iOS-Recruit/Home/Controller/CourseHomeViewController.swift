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

    lazy var collectionView: UICollectionView = {
        // TODO: 改成根據 view model 的 device 決定要什麼 layout
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewIPhoneLayout)
        collectionView.backgroundColor = .g_backgroundColor
        collectionView.dataSource = self

        CourseHomeBigCollectionViewCell.register(for: collectionView)
        CourseHomeSmallCollectionViewCell.register(for: collectionView)
        BaseCollectionReusableHeaderView.register(for: collectionView)

        view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()

        return collectionView
    }()

    var courseDataLoader = CourseDataLoader()

    var courseHomeViewModel = CourseHomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        refreshContent()
    }

    func refreshContent() {
        courseHomeViewModel.refreshContentSignal.start(Signal<CourseHomeViewModel, Error>.Observer(failed: { _ in
            // error handling
        }, completed: {
            self.collectionView.reloadData()
        }))
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

        if indexPath.item == 0, let bigCell = collectionView.dequeueReusableCell(withReuseIdentifier: CourseHomeBigCollectionViewCell.reuseIdentifier, for: indexPath) as? CourseHomeBigCollectionViewCell {

            bigCell.course = categoryModel.filterCourses[indexPath.item]

            return bigCell

        } else if let smallCell = collectionView.dequeueReusableCell(withReuseIdentifier: CourseHomeSmallCollectionViewCell.reuseIdentifier, for: indexPath) as? CourseHomeSmallCollectionViewCell {

            smallCell.course = categoryModel.filterCourses[indexPath.item]

            return smallCell
        }

        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BaseCollectionReusableHeaderView.reuseIdentifier, for: indexPath)
            if let headerView = headerView as? BaseCollectionReusableHeaderView {
                headerView.title = courseHomeViewModel.filteredCategoryModel[indexPath.section].categoryType.title
                return headerView
            }
        }
        return UICollectionReusableView()
    }

}
