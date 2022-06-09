//
//  CourseDataLoader.swift
//  Hahow-iOS-Recruit
//
//  Created by Wilson on 2022/6/9.
//

import UIKit

class CourseDataLoader: CourseDataLoaderProtocol {

    var categoryModels: [CategoryModel] = []

    func load() {
        let jsonDataHelper = JSONDataHelper(fileName: "data")
        jsonDataHelper.loadData()
        guard let data = jsonDataHelper.data else { return }

        do {
            let dataModel = try JSONDecoder().decode(DataModel.self, from: data)
            categoryModels = dataModel.categoryModels
        } catch let error {
            print(error)
        }
    }
}
