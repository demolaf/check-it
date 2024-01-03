//
//  PublicRepositoryListResponse.swift
//  check_it
//
//  Created by Ademola Fadumo on 02/01/2024.
//

import Foundation
import RealmSwift

class PublicRepositoryListResponse: Object, Codable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var repoName: String
    @Persisted var fullName: String
    @Persisted var owner: Owner?
    @Persisted var repoDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case repoName = "name"
        case fullName = "full_name"
        case owner
        case repoDescription = "description"
    }
}

class Owner: Object, Codable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var avatarUrl: String
    @Persisted var login: String
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case login
    }
}
