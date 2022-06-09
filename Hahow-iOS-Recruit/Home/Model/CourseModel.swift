//
//  CourseModel.swift
//  Hahow-iOS-Recruit
//
//  Created by Wilson on 2022/6/9.
//

import UIKit

struct CourseModel: Codable {

    private let _title: String?
    private let _coverImageString: String?
    private let _name: String?
    private let _category: String?

    var title: String { _title ?? "" }
    var coverImageString: String { _coverImageString ?? "" }
    var name: String { _name ?? ""}
    var category: String { _category ?? "" }

    var coverImageURL: URL? {
        if coverImageString.count > 0 {
            return URL(string: coverImageString)
        }
        return nil
    }

    enum CodingKeys: String, CodingKey {
        case _title = "title"
        case _coverImageString = "coverImageUrl"
        case _name = "name"
        case _category = "category"
    }

}
