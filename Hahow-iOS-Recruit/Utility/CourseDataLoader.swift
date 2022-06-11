//
//  CourseDataLoader.swift
//  Hahow-iOS-Recruit
//
//  Created by Wilson on 2022/6/9.
//

import UIKit
import ReactiveSwift

class CourseDataLoader: CourseDataLoaderProtocol {

    var categoryModels: [CategoryModel] = []

    let fileName: String = "data"

    var loadSignal: SignalProducer<CourseDataLoaderProtocol, Error> {
        return SignalProducer { [weak self] observer, _ in
            guard let self = self else { return }
            let jsonDataHelper = JSONDataHelper(fileName: self.fileName)
            jsonDataHelper.loadData()
            guard let data = jsonDataHelper.data else { return }
            do {
                let dataModel = try JSONDecoder().decode(DataModel.self, from: data)
                self.categoryModels = dataModel.categoryModels
                observer.sendCompleted()
            } catch let error {
                observer.send(error: error)
            }
        }
    }

}
