//
//  DataLoaderProtocol.swift
//  Hahow-iOS-Recruit
//
//  Created by Wilson on 2022/6/9.
//

import Foundation
import ReactiveSwift

protocol CourseDataLoaderProtocol {

    var categoryModels: [CategoryModel] { get }

    var loadSignal: SignalProducer<CourseDataLoaderProtocol, Error> { get }

}
