//
//  UserListPresenter.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import Foundation

protocol UserListPresenter: AnyObject {
    var view: UserListView? { get set }
    var interactor: UserListInteractor? { get set }
    var router: UserListRouter? { get set }

    func initialize()
    func interactorDidFetch(for repos: Result<[PublicRepositoryListResponse], APIError>)
    func navigateToUserDetails(repo: PublicRepositoryListResponse)
}

class UserListPresenterImpl: UserListPresenter {
    var router: UserListRouter?
    var interactor: UserListInteractor?
    var view: UserListView?

    func initialize() {
        Task {
            await interactor?.getPublicReposList()
        }
    }

    func interactorDidFetch(for repos: Result<[PublicRepositoryListResponse], APIError>) {
        view?.items.accept(repos)
    }

    func navigateToUserDetails(repo: PublicRepositoryListResponse) {
        router?.navigateToUserDetails(repo: repo)
    }
}
