//
//  HTTPConstants.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import Foundation

class HTTPConstants {
    enum Endpoints {
        static let baseUrl = Environment.baseUrl
        static let httpUrlScheme = "http://"
        static let httpsUrlScheme = "https://"
        static let baseUrlPrefix = "\(Endpoints.httpsUrlScheme)\(Endpoints.baseUrl)"

        case getPublicRepositories

        var stringValue: String {
            switch self {
            case .getPublicRepositories:
                return "\(Endpoints.baseUrlPrefix)/repositories"
            }
        }

        var url: URL? {
            // This handles converting string to URL and accepting spaces in query params
            return URL(string: stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        }
    }
}
