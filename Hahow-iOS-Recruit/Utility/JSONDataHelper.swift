//
//  JsonDataLoader.swift
//  Hahow-iOS-Recruit
//
//  Created by Wilson on 2022/6/9.
//

import UIKit

class JSONDataHelper: NSObject {

    private var fileName: String = ""

    init(fileName: String = "") {
        super.init()
        self.fileName = fileName
    }

}

extension JSONDataHelper: DataServiceProtocol {

    func loadCourseData(doneHandler: ((Data?, Error?) -> Void)) {
        guard fileName.count > 0, let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            let error: Error = DataServieError.pathError
            doneHandler(nil, error)
            return
        }
        let fileURL = URL(fileURLWithPath: path)
        do {
            let data: Data = try Data(contentsOf: fileURL)
            doneHandler(data, nil)
        } catch DecodingError.typeMismatch(_, _) {
            // 這邊列舉資料的錯誤，可以再擴充
            let error = DataServieError.dataFailed
            doneHandler(nil, error)
        } catch {
            doneHandler(nil, error)
        }
    }
}
