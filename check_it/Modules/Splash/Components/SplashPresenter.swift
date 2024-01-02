//
//  SplashPresenter.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import Foundation

protocol SplashPresenter: AnyObject {
    var view: SplashView? { get set }
    var interactor: SplashInteractor? { get set }
    var router: SplashRouter? { get set }

    func initialize()
}

class SplashPresenterImpl: SplashPresenter {
    var router: SplashRouter?
    var interactor: SplashInteractor?
    var view: SplashView?

    func initialize() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.router?.navigateToOnboarding()
        }
    }
}
