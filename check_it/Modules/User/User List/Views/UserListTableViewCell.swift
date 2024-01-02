//
//  UserListTableViewCell.swift
//  check_it
//
//  Created by Ademola Fadumo on 02/01/2024.
//

import UIKit

class UserListTableViewCell: UITableViewCell {
    static let reuseId = "UserListTableViewCell"
    
    private let containerHStackView: UIStackView = {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.spacing = 16
        hStack.translatesAutoresizingMaskIntoConstraints = false
        return hStack
    }()

    private let userImageView: UIImageView = {
        let imageSize = 50.0
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.image = Asset.Assets.checkitLogo.image
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = imageSize * 0.5
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { make in
            make.width.equalTo(imageSize)
        }
        imageView.translatesAutoresizingMaskIntoConstraints = true
        return imageView
    }()
    
    private let titlesVStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "[Title label here]"
        label.font = FontFamily.NunitoSans7pt.semiBold.font(size: 16)
        label.textColor = Asset.Colors.ColorScheme.headline.color
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "[Subtitle label here]"
        label.font = FontFamily.NunitoSans7pt.regular.font(size: 14)
        label.textColor = Asset.Colors.ColorScheme.body.color
        return label
    }()
    
    private let commitDetailsVStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let commitsCount: UILabel = {
        let label = UILabel()
        label.text = "30k+"
        label.font = FontFamily.NunitoSans7pt.regular.font(size: 24)
        label.textColor = Asset.Colors.ColorScheme.primary.color
        return label
    }()
    
    private let commitLabel: UILabel = {
        let label = UILabel()
        label.text = "Commits"
        label.font = FontFamily.NunitoSans7pt.regular.font(size: 14)
        label.textColor = Asset.Colors.ColorScheme.body.color
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initializeSubviews()
    }
    
    private func initializeSubviews() {
        contentView.addSubview(containerHStackView)
        contentView.addSubview(commitDetailsVStack)
        containerHStackView.addArrangedSubview(userImageView)
        containerHStackView.addArrangedSubview(titlesVStack)
        titlesVStack.addArrangedSubview(titleLabel)
        titlesVStack.addArrangedSubview(subtitleLabel)
        commitDetailsVStack.addArrangedSubview(commitsCount)
        commitDetailsVStack.addArrangedSubview(commitLabel)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyConstraints()
    }
    
    private func applyConstraints() {
        containerHStackView.snp.makeConstraints { make in
            make.leading.top.bottom.equalTo(contentView)
            make.trailing.equalTo(commitDetailsVStack.snp.leading)
        }
        commitDetailsVStack.snp.makeConstraints { make in
            make.top.bottom.trailing.equalTo(contentView)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userImageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
        commitsCount.text = nil
    }
}
