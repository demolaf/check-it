//
//  SplashRouter.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import UIKit

protocol SplashRouter: AnyObject {
    var entry: UIViewController? { get }

    static func route() -> SplashRouter

    func navigateToOnboarding()
}

class SplashRouterImpl: SplashRouter {

    var entry: UIViewController?

    static func route() -> SplashRouter {
        let router = SplashRouterImpl()

        let view = SplashViewController()
        let presenter = SplashPresenterImpl()
        let interactor = SplashInteractorImpl()

        view.presenter = presenter

        interactor.presenter = presenter

        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor

        router.entry = view
        return router
    }
    
    func navigateToOnboarding() {
        entry?.navigationController?.pushViewController(Routes.onboarding.vc, animated: true)
    }
}
