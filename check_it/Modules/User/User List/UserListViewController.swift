//
//  UserListViewController.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import UIKit
import RxSwift
import RxCocoa

protocol UserListView: AnyObject {
    var presenter: UserListPresenter? { get set }
}

class UserListViewController: UIViewController, UserListView {
    
    private let rootView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let headerView: UserListHeaderView = {
        let view = UserListHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let searchTextField: UITextField = {
        let leftView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        let rightView = UIImageView(
            image: UIImage(
                systemName: "slider.vertical.3"
            )?.withTintColor(Asset.Colors.ColorScheme.primary.color)
        )
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.borderStyle = .roundedRect
        textField.rightView = rightView
        textField.leftView = leftView
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            UserListTableViewCell.self,
            forCellReuseIdentifier: UserListTableViewCell.reuseId
        )
        tableView.separatorInset = .zero
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.darkGray
        refreshControl.addAction(
            UIAction { [weak self] _ in
                self?.presenter?.initialize()
            },
            for: .valueChanged
        )
        return refreshControl
    }()
    
    private let bag = DisposeBag()
    
    private let items = BehaviorRelay<[String]>(value: ["1", "2", "3", "4", "5"])
    
    var presenter: UserListPresenter?
    
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
    
    private func initializeViewAppearance() {
        view.backgroundColor = Asset.Colors.ColorScheme.background.color
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isHidden = true
    }
    
    private func initializeSubviews() {
        view.addSubview(rootView)
        rootView.addSubview(headerView)
        rootView.addSubview(searchTextField)
        rootView.addSubview(tableView)
        tableView.refreshControl = refreshControl
        bindTableView()
    }
    
    private func applyConstraints() {
        rootView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        headerView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(rootView)
            make.bottom.equalTo(searchTextField.snp.top).offset(-24)
        }
        searchTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(rootView)
            make.bottom.equalTo(tableView.snp.top).offset(-36)
        }
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(rootView)
        }
    }
    
    private func bindTableView() {
        //        items
        //            .debug("items in resuable vc")
        //            .subscribe(onNext: {[weak self] items in
        //                DispatchQueue.main.async {
        //                    if items.isEmpty {
        //                        self?.tableView.setEmptyView(
        //                            title: "No Items",
        //                            message: ""
        //                        )
        //                    } else {
        //                        self?.tableView.restore()
        //                    }
        //                }
        //            })
        //            .disposed(by: bag)
        //
        // Bind items to table
        items.bind(
            to: tableView.rx.items(
                cellIdentifier: UserListTableViewCell.reuseId,
                cellType: UserListTableViewCell.self)
        ) { _, item, cell in
            cell.selectionStyle = .none
        }
        .disposed(by: bag)
        
        // Bind a model selected handler
        tableView.rx.modelSelected(String.self).bind { [weak self] item in
            debugPrint("Item tapped \(item)")
            self?.presenter?.navigateToUserDetails()
        }
        .disposed(by: bag)
        
        tableView.rx.rowHeight.onNext(96)
        tableView.rx.estimatedRowHeight.onNext(96)
    }
}
