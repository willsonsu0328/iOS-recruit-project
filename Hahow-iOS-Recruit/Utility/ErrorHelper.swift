//
//  ErrorHelper.swift
//  Hahow-iOS-Recruit
//
//  Created by Wilson on 2022/6/12.
//

import Foundation

enum DataServieError: Error {
    case unknownError
    case pathError
    case dataFailed
    case serverError
}

extension DataServieError: LocalizedError {

    var errorDescription: String? {
        var msg = ""
        switch self {
        case .unknownError:
            msg = NSLocalizedString("error_unknownerror", comment: "")
        case .pathError:
            msg = NSLocalizedString("error_patherror", comment: "")
        case .dataFailed:
            msg = NSLocalizedString("error_dataFailed", comment: "")
        case .serverError:
            msg = NSLocalizedString("error_serverError", comment: "")
        }
        return msg
    }

}
