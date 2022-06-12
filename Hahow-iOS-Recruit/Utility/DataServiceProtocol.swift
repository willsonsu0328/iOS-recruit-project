//
//  DataLoaderProtocol.swift
//  Hahow-iOS-Recruit
//
//  Created by Wilson on 2022/6/9.
//

import Foundation
import ReactiveSwift

protocol DataServiceProtocol {

    // 抽象讀取資料，若有 API 或其他讀取資料方式，可以在此擴充
    func loadCourseData(doneHandler: ((_ data: Data?, _ error: Error?) -> Void))

}
