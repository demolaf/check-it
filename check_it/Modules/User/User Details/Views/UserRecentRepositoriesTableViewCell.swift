//
//  UserRecentRepositoriesTableViewCell.swift
//  check_it
//
//  Created by Ademola Fadumo on 02/01/2024.
//

import UIKit

class UserRecentRepositoriesTableViewCell: UITableViewCell {
    static let reuseId = "UserRecentRepositoriesTableViewCell"
    
    private let rootView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = Asset.Colors.CustomColors.border.color.cgColor
        view.layer.borderWidth = 1
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints =  false
        return view
    }()
    
    private let topItemsHStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        return stack
    }()
    
    private let folderIconHStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 14
        stack.distribution = .fill
        return stack
    }()
    
    private let folderIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(
            systemName: "folder.fill"
        )?.withTintColor(
            Asset.Colors.ColorScheme.primary.color,
            renderingMode: .alwaysOriginal
        )
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ".devops"
        label.font = FontFamily.NunitoSans7pt.semiBold.font(size: 14)
        label.textColor = Asset.Colors.ColorScheme.headline.color
        return label
    }()
    
    private let lastUpdatedDateLabel: UILabel = {
        let label = UILabel()
        label.text = "1 hour ago"
        label.font = FontFamily.NunitoSans7pt.regular.font(size: 14)
        label.textColor = Asset.Colors.ColorScheme.headline.color
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "devops: added systemized units and set versioning date"
        label.numberOfLines = 2
        label.font = FontFamily.NunitoSans7pt.regular.font(size: 12)
        label.textColor = Asset.Colors.ColorScheme.body.color
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initializeSubviews()
    }
    
    private func initializeSubviews() {
        contentView.addSubview(rootView)
        rootView.addSubview(topItemsHStack)
        rootView.addSubview(descriptionLabel)
        topItemsHStack.addArrangedSubview(folderIconHStack)
        topItemsHStack.addArrangedSubview(lastUpdatedDateLabel)
        folderIconHStack.addArrangedSubview(folderIcon)
        folderIconHStack.addArrangedSubview(titleLabel)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyConstraints()
    }
    
    private func applyConstraints() {
        rootView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(
                UIEdgeInsets(
                    top: 0,
                    left: 0,
                    bottom: 16,
                    right: 0
                )
            )
        }
        topItemsHStack.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(rootView).inset(16)
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-8)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(rootView).inset(16)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
