//
//  CourseHomeViewModel.swift
//  Hahow-iOS-Recruit
//
//  Created by Wilson on 2022/6/11.
//

import UIKit
import ReactiveSwift

class CourseHomeViewModel: NSObject {

    // MARK: Setting

    var currentDeviceModel: UIUserInterfaceIdiom {
        UIDevice.current.userInterfaceIdiom
    }

    // MARK: Presentation

    enum CellType: Int {
        case bigCell
        case smallCell
    }

    // 根據裝置及需求設定不同 cell type
    func cellType(for indexPath: IndexPath) -> CellType {
        var cellType: CellType = .smallCell
        switch currentDeviceModel {
        case .phone:
            if indexPath.item == 0 {
                cellType = .bigCell
            } else {
                cellType = .smallCell
            }
        case .pad:
            cellType = .smallCell
        default:
            break
        }
        return cellType
    }

    // MARK: Storage

    var categoryModels: [CategoryModel] = [] {
        didSet {
            filteredCategoryModel = categoryModels
            switch currentDeviceModel {
            case .phone:
                filterCategoryModels(prefix: 3)
            case .pad:
                filterCategoryModels(prefix: 4)
            default:
                break
            }
        }
    }
    var filteredCategoryModel: [CategoryModel] = []
    private let courseDataLoader = CourseDataLoader(dataService: JSONDataHelper(fileName: "data"))

    // MARK: Signals

    // 多建立一個 refreshContentSignal，方便之後擴充，不用更改 controller
    var refreshContentSignal: SignalProducer<Void, Error> {
        return coursesSignal
    }

    var coursesSignal: SignalProducer<Void, Error> {
        return SignalProducer { [weak self] observer, _ in
            guard let self = self else { return }
            self.courseDataLoader.loadSignal.start(Signal<[CategoryModel], Error>.Observer(value: { categoryModels in
                self.categoryModels = categoryModels
            }, failed: { error in
                observer.send(error: error)
            }, completed: {
                observer.sendCompleted()
            }))
        }
    }

    // MARK: Helper

    // 處理課程資料顯示數量
    func filterCategoryModels(prefix: Int) {
        for categoryModel in filteredCategoryModel {
            if categoryModel.courses.count > prefix {
                categoryModel.filterCourses = Array(categoryModel.courses.prefix(prefix))
            } else {
                categoryModel.filterCourses = categoryModel.courses
            }
        }
    }

}
