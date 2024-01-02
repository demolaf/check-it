//
//  GithubAPI.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import Foundation
import RxSwift

class GithubAPI {
    let httpClient: HTTPClient
    let localStorage: LocalStorage

    init(httpClient: HTTPClient, localStorage: LocalStorage) {
        self.httpClient = httpClient
        self.localStorage = localStorage
    }
}
