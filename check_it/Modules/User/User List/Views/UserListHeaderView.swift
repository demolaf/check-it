//
//  HeaderView.swift
//  check_it
//
//  Created by Ademola Fadumo on 02/01/2024.
//

import UIKit

class UserListHeaderView: UIView {
    
    private let rootVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        return stack
    }()

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "GitHub Explorer"
        label.font = FontFamily.NunitoSans7pt.bold.font(size: 20)
        label.textColor = Asset.Colors.ColorScheme.headline.color
        return label
    }()
    
    private lazy var notificationsButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.configuration?.contentInsets = .zero
        button.setImage(
            UIImage(systemName: "bell")?.withTintColor(
                Asset.Colors.ColorScheme.primary.color,
                renderingMode: .alwaysOriginal
            ),
            for: .normal
        )
        button.addAction(
            UIAction {[weak self] _ in
            },
            for: .primaryActionTriggered
        )
        button.snp.makeConstraints { make in
            make.size.equalTo(44)
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let subHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Connect and Collaborate with the Community"
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.font = FontFamily.NunitoSans7pt.regular.font(size: 16)
        label.textColor = Asset.Colors.ColorScheme.body.color
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    private func initializeSubviews() {
        addSubview(rootVStack)
        rootVStack.addArrangedSubview(hStack)
        rootVStack.addArrangedSubview(subHeaderLabel)
        hStack.addArrangedSubview(headerLabel)
        hStack.addArrangedSubview(notificationsButton)
    }

    required init(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        applyConstraints()
    }
    
    private func applyConstraints() {
        rootVStack.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}
