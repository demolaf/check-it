//
//  Environment.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import Foundation

public enum Environment {
    enum Keys {
        static let baseUrl = "BASE_URL"
    }

    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist file not found")
        }

        return dict
    }()

    static let baseUrl: String = {
        guard let baseUrlString = Environment.infoDictionary[Keys.baseUrl] as? String else {
            fatalError("BASE_URL not set in plist")
        }

        return baseUrlString
    }()
}
