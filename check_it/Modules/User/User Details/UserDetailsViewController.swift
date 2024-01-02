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
    private let rootView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let userDetailsHeaderView: UIView = {
        let view = UserDetailsHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let userDetailsDescriptionView: UIView = {
        let view = UserDetailsDescriptionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let userDetailsRecentRepositoriesView: UIView = {
        let view = UserDetailsRecentRepositoriesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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
    private func initializeViewAppearance() {
        view.backgroundColor = Asset.Colors.ColorScheme.background.color
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "bookmark")!,
            style: .plain,
            target: self,
            action: #selector(bookmarkButtonPressed)
        )
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.tintColor = .label
    }
    
    private func initializeSubviews() {
        view.addSubview(rootView)
        rootView.addSubview(userDetailsHeaderView)
        rootView.addSubview(userDetailsDescriptionView)
        rootView.addSubview(userDetailsRecentRepositoriesView)
    }
    
    private func applyConstraints() {
        rootView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        userDetailsHeaderView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(rootView)
            make.bottom.equalTo(userDetailsDescriptionView.snp.top).offset(-24)
        }
        userDetailsDescriptionView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(rootView)
            make.bottom.equalTo(userDetailsRecentRepositoriesView.snp.top).offset(-36)
        }
        userDetailsRecentRepositoriesView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(rootView)
        }
    }
    
    @objc
    private func bookmarkButtonPressed() {
        debugPrint("bookmark button pressed")
    }
}

#Preview {
    Routes.userDetails.vc
}
