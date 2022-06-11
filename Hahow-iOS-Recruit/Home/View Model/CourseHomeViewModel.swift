//
//  CourseHomeViewModel.swift
//  Hahow-iOS-Recruit
//
//  Created by Wilson on 2022/6/11.
//

import UIKit
import ReactiveSwift

class CourseHomeViewModel: BaseViewModel {

    // MARK: Setting

    var currentDeviceModel: UIUserInterfaceIdiom {
        UIDevice.current.userInterfaceIdiom
    }

    // MARK: Storage

    var categoryModels: [CategoryModel] = [] {
        didSet {
            filteredCategoryModel = categoryModels
            if currentDeviceModel == .phone {
                filterCategoryModels(prefix: 3)
            }
        }
    }
    var filteredCategoryModel: [CategoryModel] = []
    private let courseDataLoader = CourseDataLoader()

    // MARK: Signals

    var refreshContentSignal: SignalProducer<CourseHomeViewModel, Error> {
        return coursesSignal
    }

    var coursesSignal: SignalProducer<CourseHomeViewModel, Error> {
        return SignalProducer { [weak self] observer, _ in
            guard let self = self else { return }
            self.courseDataLoader.loadSignal.start(Signal<CourseDataLoaderProtocol, Error>.Observer(failed: { error in
                observer.send(error: error)
            }, completed: {
                self.categoryModels = self.courseDataLoader.categoryModels
                observer.sendCompleted()
            }))
        }
    }

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
