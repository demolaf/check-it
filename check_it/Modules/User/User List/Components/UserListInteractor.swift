//
//  UserListInteractor.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import Foundation

protocol UserListInteractor: AnyObject {
    var presenter: UserListPresenter? { get set }
    
    func getPublicReposList(db: Bool) async
}

class UserListInteractorImpl: UserListInteractor {
    var presenter: UserListPresenter?
    var githubRepository: GithubRepository?
    
    func getPublicReposList(db: Bool) async {
        guard let githubRepository = githubRepository else {
            fatalError("GithubRepository dependency was not provided")
        }
        let result = await githubRepository.getPublicReposList(db: db)
        presenter?.interactorDidFetch(for: result)
    }
}
