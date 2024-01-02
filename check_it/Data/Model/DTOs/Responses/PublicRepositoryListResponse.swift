//
//  PublicRepositoryListResponse.swift
//  check_it
//
//  Created by Ademola Fadumo on 02/01/2024.
//

import Foundation

struct PublicRepositoryListResponse: Codable {
    let id: Int
    let repoName: String
    let fullName: String
    let owner: Owner
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case repoName = "name"
        case fullName = "full_name"
        case owner
        case description
    }
}

struct Owner: Codable {
    let id: Int
    let avatarUrl: String
    let login: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case avatarUrl = "avatar_url"
        case login
    }
}
