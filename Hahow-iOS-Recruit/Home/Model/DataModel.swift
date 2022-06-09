//
//  DataModel.swift
//  Hahow-iOS-Recruit
//
//  Created by Wilson on 2022/6/10.
//

import UIKit

class DataModel: Codable {

    private let _categoryModels: [CategoryModel]?

    var categoryModels: [CategoryModel] { _categoryModels ?? [] }

    enum CodingKeys: String, CodingKey {
        case _categoryModels = "data"
    }
}
