//
//  CategoryModel.swift
//  Hahow-iOS-Recruit
//
//  Created by Wilson on 2022/6/9.
//

import UIKit

class CategoryModel: Codable {

    enum CategoryType: String, Codable {
        case undefined = ""
        case programming
        case design
        case language
        case music

        var title: String {

            var title = ""
            switch self {
            case .programming:
                title = NSLocalizedString("coursehome_categoryprogramming", comment: "")
            case .design:
                title = NSLocalizedString("coursehome_categorydesign", comment: "")
            case .language:
                title = NSLocalizedString("coursehome_categorylanguage", comment: "")
            case .music:
                title = NSLocalizedString("coursehome_categorymusic", comment: "")
            case .undefined:
                title = ""
            }
            return title
        }
    }

    private let _courses: [CourseModel]?
    private let _categoryType: CategoryType?

    var courses: [CourseModel] { _courses ?? [] }
    var categoryType: CategoryType { _categoryType ?? .undefined}
    var filterCourses: [CourseModel] = []

    enum CodingKeys: String, CodingKey {
        case _courses = "courses"
        case _categoryType = "category"
    }

}
