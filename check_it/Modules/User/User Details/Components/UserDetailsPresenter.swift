//
//  UserDetailsPresenter.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import Foundation

protocol UserDetailsPresenter: AnyObject {
    var view: UserDetailsView? { get set }
    var interactor: UserDetailsInteractor? { get set }
    var router: UserDetailsRouter? { get set }

    func initialize()
}

class UserDetailsPresenterImpl: UserDetailsPresenter {
    var router: UserDetailsRouter?
    var interactor: UserDetailsInteractor?
    var view: UserDetailsView?

    func initialize() {}
}
