//
//  GithubRepository.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import Foundation

protocol GithubRepository {
    func getPublicReposList() async -> Result<[PublicRepositoryListResponse], APIError>
}
