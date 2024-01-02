//
//  OnboardingRouter.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import UIKit

protocol OnboardingRouter: AnyObject {
    var entry: UIViewController? { get }

    static func route() -> OnboardingRouter
    
    func navigateToUserList()
}

class OnboardingRouterImpl: OnboardingRouter {

    var entry: UIViewController?

    static func route() -> OnboardingRouter {
        let router = OnboardingRouterImpl()

        let view = OnboardingViewController()
        let presenter = OnboardingPresenterImpl()
        let interactor = OnboardingInteractorImpl()

        view.presenter = presenter

        interactor.presenter = presenter

        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor

        router.entry = view
        return router
    }
    
    func navigateToUserList() {
        entry?.navigationController?.pushViewController(Routes.userList.vc, animated: true)
    }
}
