//
//  GithubRepositoryImpl.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import Foundation

class GithubRepositoryImpl: GithubRepository {
    let githubAPI: GithubAPI

    init(githubAPI: GithubAPI) {
        self.githubAPI = githubAPI
    }

    func getPublicReposList() async -> Result<[PublicRepositoryListResponse], CustomDataError> {
        await githubAPI.fetchPublicReposList()
    }
    
    func getPublicReposListFromDB() -> Result<[PublicRepositoryListResponse], CustomDataError> {
        githubAPI.fetchPublicReposListFromDB()
    }
}
