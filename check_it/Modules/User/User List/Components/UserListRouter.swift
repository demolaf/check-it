//
//  UserListRouter.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import UIKit

protocol UserListRouter: AnyObject {
    var entry: UIViewController? { get }

    static func route() -> UserListRouter
    
    func navigateToUserDetails(repo: PublicRepositoryListResponse)
}

class UserListRouterImpl: UserListRouter {

    var entry: UIViewController?

    static func route() -> UserListRouter {
        let router = UserListRouterImpl()

        let view = UserListViewController()
        let presenter = UserListPresenterImpl()
        let interactor = UserListInteractorImpl()

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
    
    func navigateToUserDetails(repo: PublicRepositoryListResponse) {
        guard let userDetailsVC = Routes.userDetails.vc as? UserDetailsViewController else {
            fatalError("Failed to navigate to user details VC")
        }
        userDetailsVC.configure(with: repo)
        entry?.navigationController?.pushViewController(userDetailsVC, animated: true)
    }
}
