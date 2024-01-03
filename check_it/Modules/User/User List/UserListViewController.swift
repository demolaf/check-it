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
    var items: BehaviorRelay<[PublicRepositoryListResponse]> { get set }
    
    func showErrorAlert()
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
    
    private let searchTextField: UserListSearchTextField = {
        let textField = UserListSearchTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            UserListTableViewCell.self,
            forCellReuseIdentifier: UserListTableViewCell.reuseId
        )
        tableView.showsVerticalScrollIndicator = false
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
    
    var items = BehaviorRelay<[PublicRepositoryListResponse]>(value: [])
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func initializeViewAppearance() {
        view.backgroundColor = Asset.Colors.ColorScheme.background.color
        navigationItem.hidesBackButton = true
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
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.bottom.equalTo(view)
        }
        headerView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(rootView)
            make.bottom.equalTo(searchTextField.snp.top).offset(-24)
        }
        searchTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(rootView)
            make.bottom.equalTo(tableView.snp.top).offset(-24)
            make.height.equalTo(56)
        }
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(rootView)
        }
    }
    
    private func bindTableView() {
        items
            .debug("items in user list vc")
            .flatMap { [weak self] repos -> Observable<[PublicRepositoryListResponse]> in
                guard let self = self else {
                    debugPrint("self is nil in items relay")
                    Task {
                        self?.refreshControl.endRefreshing()
                    }
                    return Observable.empty()
                }
                
                Task {
                    self.refreshControl.endRefreshing()
                }
                return Observable.from(optional: repos)
            }
            .bind(
                to: tableView.rx.items(
                    cellIdentifier: UserListTableViewCell.reuseId,
                    cellType: UserListTableViewCell.self)
            ) { _, item, cell in
                cell.selectionStyle = .none
                cell.configure(with: item)
            }
            .disposed(by: bag)
        
        tableView.rx.modelSelected(PublicRepositoryListResponse.self).bind { [weak self] repo in
            self?.presenter?.navigateToUserDetails(repo: repo)
        }
        .disposed(by: bag)
        
        tableView.rx.rowHeight.onNext(104)
        tableView.rx.estimatedRowHeight.onNext(104)
        
        tableView.rx.didScroll.subscribe(onNext: { [weak self] _ in
            guard let self = self else {
                debugPrint("self is nil in items relay")
                return
            }
            
            guard (self.presenter?.hasMoreData ?? false) else {
                DispatchQueue.main.async {
                    self.tableView.tableFooterView = nil
                }
                return
            }
            
            if self.presenter?.isPaginating ?? true {
                self.tableView.tableFooterView = createSpinnerFooter()
            }
            
            let position = self.tableView.contentOffset.y
            if position > (self.tableView.contentSize.height - 100) - tableView.frame.size.height {
                guard !(self.presenter?.isPaginating ?? true) else {
                    return
                }
                self.presenter?.fetchRepos()
                
                DispatchQueue.main.async {
                    self.tableView.tableFooterView = nil
                }
            }
        })
        .disposed(by: bag)
    }
    
    func createSpinnerFooter() -> UIView {
        let footerView = UIView(
            frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50)
        )
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    func showErrorAlert() {
        Task {
            self.refreshControl.endRefreshing()
            self.showAlert("Error", message: "Error fetching repos")
                .subscribe(onDisposed: {
                    debugPrint("alert disposed")
                })
                .disposed(by: self.bag)
        }
    }
}

//#Preview {
//    Routes.userList.vc
//}
