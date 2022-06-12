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

    private let maxDisplayItemsForIPhone: Int = 3
    private let maxDisplayItemsForIPad: Int = 4

    // 處理課程顯示數量
    func displayItemCount(for section: Int) -> Int {
        var count: Int = 0
        let courses = categoryModels[section].courses
        switch currentDeviceModel {
        case .phone:
            count = (courses.count >= maxDisplayItemsForIPhone) ? maxDisplayItemsForIPhone : courses.count
        case .pad:
            count = (courses.count >= maxDisplayItemsForIPad) ? maxDisplayItemsForIPad : courses.count
        default:
            break
        }
        return count
    }

    // MARK: Storage

    var categoryModels: [CategoryModel] = []
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

}
