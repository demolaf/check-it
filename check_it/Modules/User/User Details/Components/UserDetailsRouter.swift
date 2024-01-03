//
//  UserDetailsRouter.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import UIKit

protocol UserDetailsRouter: AnyObject {
    var entry: UIViewController? { get }

    static func route() -> UserDetailsRouter
}

class UserDetailsRouterImpl: UserDetailsRouter {

    var entry: UIViewController?

    static func route() -> UserDetailsRouter {
        let router = UserDetailsRouterImpl()

        let view = UserDetailsViewController()
        let presenter = UserDetailsPresenterImpl()
        let interactor = UserDetailsInteractorImpl()

        view.presenter = presenter

        interactor.presenter = presenter
        interactor.githubRepository =
        (UIApplication.shared.delegate as? AppDelegate)?
            .repositoryProvider
            .githubRepository

        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor

        router.entry = view
        return router
    }
}
