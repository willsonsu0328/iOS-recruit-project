//
//  DataLoaderProtocol.swift
//  Hahow-iOS-Recruit
//
//  Created by Wilson on 2022/6/9.
//

import Foundation

protocol CourseDataLoaderProtocol {

    var categoryModels: [CategoryModel] { get }

    func load()

}
