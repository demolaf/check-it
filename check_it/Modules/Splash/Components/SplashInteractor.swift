//
//  SplashInteractor.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import Foundation

protocol SplashInteractor: AnyObject {
     var presenter: SplashPresenter? { get set }
}

class SplashInteractorImpl: SplashInteractor {
    var presenter: SplashPresenter?
}
