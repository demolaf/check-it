//
//  UserDetailsRecentRepositoriesView.swift
//  check_it
//
//  Created by Ademola Fadumo on 02/01/2024.
//

import UIKit
import RxSwift
import RxCocoa

class UserDetailsRecentRepositoriesView: UIView {
    private let containerVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let sectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Recent Repositories"
        label.font = FontFamily.NunitoSans7pt.bold.font(size: 14)
        label.textColor = Asset.Colors.ColorScheme.headline.color
        return label
    }()
    
    private let subSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Navigate their codebase and development history"
        label.font = FontFamily.NunitoSans7pt.regular.font(size: 12)
        label.textColor = Asset.Colors.ColorScheme.body.color
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            UserRecentRepositoriesTableViewCell.self,
            forCellReuseIdentifier: UserRecentRepositoriesTableViewCell.reuseId
        )
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let bag = DisposeBag()
    
    private let items = BehaviorRelay<[String]>(value: ["1", "2", "3", "4", "5"])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
        bindTableView()
    }
    
    private func initializeSubviews() {
        addSubview(containerVStack)
        addSubview(tableView)
        containerVStack.addArrangedSubview(sectionLabel)
        containerVStack.addArrangedSubview(subSectionLabel)
    }
    
    private func bindTableView() {
        items.bind(
            to: tableView.rx.items(
                cellIdentifier: UserRecentRepositoriesTableViewCell.reuseId,
                cellType: UserRecentRepositoriesTableViewCell.self)
        ) { _, item, cell in
            cell.selectionStyle = .none
        }
        .disposed(by: bag)
        
        // Bind a model selected handler
        tableView.rx.modelSelected(String.self).bind { [weak self] item in
            debugPrint("Item tapped \(item)")
        }
        .disposed(by: bag)
        
        tableView.rx.rowHeight.onNext(120)
        tableView.rx.estimatedRowHeight.onNext(120)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyConstraints()
    }
    
    private func applyConstraints() {
        containerVStack.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(self)
            make.bottom.equalTo(tableView.snp.top).offset(-24)
        }
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(self)
        }
    }
}
