//
//  DataLoaderProtocol.swift
//  Hahow-iOS-Recruit
//
//  Created by Wilson on 2022/6/9.
//

import Foundation
import ReactiveSwift

protocol DataServiceProtocol {

    func loadCourseData(doneHandler: ((_ data: Data?, _ error: Error?) -> Void))

}
