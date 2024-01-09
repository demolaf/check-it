//
//  UserDetailsInteractor.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import Foundation

protocol UserDetailsInteractor: AnyObject {
     var presenter: UserDetailsPresenter? { get set }
}

class UserDetailsInteractorImpl: UserDetailsInteractor {
    var presenter: UserDetailsPresenter?
}

