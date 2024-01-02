//
//  UserListInteractor.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import Foundation

protocol UserListInteractor: AnyObject {
     var presenter: UserListPresenter? { get set }

     func getDetails()
}

class UserListInteractorImpl: UserListInteractor {
    var presenter: UserListPresenter?
    var githubRepository: GithubRepository?
    
    func getDetails() {
        Task {
            let users = await githubRepository?.getUsersList()
        }
    }
}
