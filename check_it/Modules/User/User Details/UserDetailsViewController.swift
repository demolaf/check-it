//
//  UserDetailsViewController.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import UIKit

protocol UserDetailsView: AnyObject {
    var presenter: UserDetailsPresenter? { get set }
}

class UserDetailsViewController: UIViewController, UserDetailsView {
    var presenter: UserDetailsPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeViewAppearance()
        initializeSubviews()

        presenter?.initialize()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyConstraints()
    }
}

extension UserDetailsViewController {
    private func initializeViewAppearance() {}
    
    private func initializeSubviews() {}
    
    private func applyConstraints() {}
}
