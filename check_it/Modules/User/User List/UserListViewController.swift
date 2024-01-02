//
//  UserListViewController.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import UIKit

protocol UserListView: AnyObject {
    var presenter: UserListPresenter? { get set }
}

class UserListViewController: UIViewController, UserListView {
    var presenter: UserListPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.initialize()
    }
}

extension UserListViewController {
    func initializeViewAppearance() {
        view.backgroundColor = Asset.Colors.ColorScheme.background.color
        navigationItem.hidesBackButton = true
    }
}
