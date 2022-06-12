//
//  CourseDataLoader.swift
//  Hahow-iOS-Recruit
//
//  Created by Wilson on 2022/6/9.
//

import UIKit
import ReactiveSwift

class CourseDataLoader: NSObject {

    var categoryModels: [CategoryModel] = []

    var dataService: DataServiceProtocol

    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
        super.init()
    }

    var loadSignal: SignalProducer<CourseDataLoader, Error> {
        return SignalProducer { [weak self] observer, _ in
            guard let self = self else { return }
            self.dataService.loadCourseData { data, error in
                if let error = error {
                    observer.send(error: error)
                }
                guard let data = data else { return }
                do {
                    let dataModel = try JSONDecoder().decode(DataModel.self, from: data)
                    self.categoryModels = dataModel.categoryModels
                    observer.sendCompleted()
                } catch {
                    // 有需要可再列舉其他錯誤
                    observer.send(error: error)
                }
            }
        }
    }

}
