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
}

class UserListPresenterImpl: UserListPresenter {
    var router: UserListRouter?
    var interactor: UserListInteractor?
    var view: UserListView?

    func initialize() {}
}
