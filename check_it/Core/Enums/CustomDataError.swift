//
//  APIError.swift
//  check_it
//
//  Created by Ademola Fadumo on 02/01/2024.
//

import Foundation

enum CustomDataError: Error {
    case failedToFetchData
    case failedToSendData
    case failedToStoreData
}
