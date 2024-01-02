//
//  UserDetailsInteractor.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import Foundation

// Interactor usually uses two protocols:
// 1. for actions from the presenter
// 2. for actions from itself
// i.e interactor input and output protocols
protocol UserDetailsInteractor: AnyObject {
     var presenter: UserDetailsPresenter? { get set }
}

class UserDetailsInteractorImpl: UserDetailsInteractor {
    var presenter: UserDetailsPresenter?

    var githubRepository: GithubRepository?
}

