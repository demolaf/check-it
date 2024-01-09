//
//  RepositoryProvider.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import Foundation

class RepositoryProvider {
    static let shared = RepositoryProvider()
    
    let githubRepository: GithubRepository

    private let httpClient: HTTPClient
    private var localStorage: LocalStorage
    private let githubAPI: GithubAPI

    private init() {
        // External services
        httpClient = HTTPClientImpl()
        localStorage = LocalStorageImpl()

        // APIs interact with http client and local storage
        githubAPI = GithubAPI(httpClient: httpClient, localStorage: localStorage)

        // Repositories interact only directly with APIs
        githubRepository = GithubRepositoryImpl(githubAPI: githubAPI)
    }
}
