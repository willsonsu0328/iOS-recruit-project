//
//  JsonDataLoader.swift
//  Hahow-iOS-Recruit
//
//  Created by Wilson on 2022/6/9.
//

import UIKit

class JSONDataHelper: NSObject {

    var data: Data?
    private var fileName: String = ""

    init(fileName: String = "") {
        super.init()
        self.fileName = fileName
    }

    func loadData() {
        if fileName.count > 0 {
            guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else { return }
            let fileURL = URL(fileURLWithPath: path)
            data = try? Data(contentsOf: fileURL)
        }
    }

}
