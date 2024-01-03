//
//  GithubAPI.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import Foundation
import RxSwift
import RealmSwift

class GithubAPI {
    let httpClient: HTTPClient
    let localStorage: LocalStorage
    
    init(httpClient: HTTPClient, localStorage: LocalStorage) {
        self.httpClient = httpClient
        self.localStorage = localStorage
    }
    
    func fetchPublicReposList() async -> Result<[PublicRepositoryListResponse], CustomDataError> {
        self.storePublicReposList()

        return await httpClient.get(
            url: HTTPConstants.Endpoints.getPublicRepositories.url,
            headers: nil,
            response: [PublicRepositoryListResponse].self
        )
    }
    
    func fetchPublicReposListFromDB() -> Result<[PublicRepositoryListResponse], CustomDataError> {
        return localStorage.readAll(
            object: PublicRepositoryListResponse.self,
            sortBy: nil,
            predicate: nil
        )
    }
    
    private func storePublicReposList() {
        Task {
            let result = await httpClient.get(
                url: HTTPConstants.Endpoints.getPublicRepositories.url,
                headers: nil,
                response: [PublicRepositoryListResponse].self
            )
            switch result {
            case .success(let repos):
                DispatchQueue.main.async {
                    _ = self.localStorage.delete()
                    for repo in repos {
                        _ = self.localStorage.create(object: repo)
                    }
                }
            case .failure(let error):
                debugPrint("Error \(error)")
            }
        }
    }
}
