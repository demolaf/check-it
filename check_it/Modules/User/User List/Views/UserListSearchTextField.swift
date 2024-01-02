//
//  UserListSearchTextField.swift
//  check_it
//
//  Created by Ademola Fadumo on 02/01/2024.
//

import UIKit

class UserListSearchTextField: UIView {

    private lazy var searchTextField: UITextField = {
        let leftView = searchTextFieldIconViewBuilder(
            icon: "magnifyingglass",
            color: Asset.Colors.CustomColors.icon.color
        )
        let rightView = searchTextFieldIconViewBuilder(
            icon: "slider.vertical.3",
            color: Asset.Colors.ColorScheme.primary.color
        )
        let textField = UITextField()
        let placeholderText = "Search Users by Name or Email"
        let placeholderRange = placeholderText.range(of: placeholderText)!
        let attributedString = NSMutableAttributedString(string: placeholderText)
        attributedString.addAttributes(
            [NSAttributedString.Key.foregroundColor: Asset.Colors.CustomColors.textFieldPlaceholder.color,
             NSAttributedString.Key.font: FontFamily.NunitoSans7pt.regular.font(size: 14)
            ],
            range: NSRange(placeholderRange, in: placeholderText)
        )
        textField.attributedPlaceholder = attributedString
        textField.autocapitalizationType = .none
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = Asset.Colors.CustomColors.border.color.cgColor
        textField.layer.borderWidth = 1
        textField.rightView = rightView
        textField.rightViewMode = .always
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyConstraints()
    }
    
    private func initializeSubviews() {
        addSubview(searchTextField)
    }
    
    private func applyConstraints() {
        searchTextField.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    private func searchTextFieldIconViewBuilder(
        icon: String,
        color: UIColor
    ) -> UIView {
        let view = UIView()
        let icon = UIImageView(
            image: UIImage(systemName: icon)?.withTintColor(
                color,
                renderingMode: .alwaysOriginal
            )
        )
        view.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.edges.equalTo(view).inset(
                UIEdgeInsets(
                    top: 0,
                    left: 16,
                    bottom: 0,
                    right: 16
                )
            )
        }
        return view
    }
}
