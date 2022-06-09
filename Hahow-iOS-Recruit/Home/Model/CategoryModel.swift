//
//  CategoryModel.swift
//  Hahow-iOS-Recruit
//
//  Created by Wilson on 2022/6/9.
//

import UIKit

struct CategoryModel: Codable {

    private let _category: String?
    private let _courses: [CourseModel]?

    var category: String { _category ?? "" }
    var courses: [CourseModel] { _courses ?? [] }

    enum CodingKeys: String, CodingKey {
        case _category = "category"
        case _courses = "courses"
    }

}
