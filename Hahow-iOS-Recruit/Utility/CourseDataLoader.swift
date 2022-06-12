//
//  CourseDataLoader.swift
//  Hahow-iOS-Recruit
//
//  Created by Wilson on 2022/6/9.
//

import UIKit
import ReactiveSwift

// 負責處理課程相關資料的來源
class CourseDataLoader: NSObject {

    var dataService: DataServiceProtocol

    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
        super.init()
    }

    var loadSignal: SignalProducer<[CategoryModel], Error> {
        return SignalProducer { [weak self] observer, _ in
            guard let self = self else { return }
            self.dataService.loadCourseData { data, error in
                if let error = error {
                    observer.send(error: error)
                }
                guard let data = data else {
                    let error = DataServieError.dataFailed
                    observer.send(error: error)
                    return
                }
                do {
                    let dataModel = try JSONDecoder().decode(DataModel.self, from: data)
                    observer.send(value: dataModel.categoryModels)
                    observer.sendCompleted()
                } catch {
                    // 有需要可再列舉其他錯誤
                    observer.send(error: error)
                }
            }
        }
    }

}
