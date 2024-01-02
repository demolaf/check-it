//
//  UserListTableViewCell.swift
//  check_it
//
//  Created by Ademola Fadumo on 02/01/2024.
//

import UIKit
import SDWebImage

class UserListTableViewCell: UITableViewCell {
    static let reuseId = "UserListTableViewCell"
    
    private let containerHStackView: UIStackView = {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.distribution = .equalSpacing
        hStack.alignment = .center
        hStack.translatesAutoresizingMaskIntoConstraints = false
        return hStack
    }()
    
    private let imageAndTitleStackView: UIStackView = {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.distribution = .fill
        hStack.spacing = 12
        hStack.alignment = .leading
        hStack.translatesAutoresizingMaskIntoConstraints = false
        return hStack
    }()
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = true
        return imageView
    }()
    
    private let titlesVStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 4
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
        stack.distribution = .fill
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
        containerHStackView.addArrangedSubview(imageAndTitleStackView)
        containerHStackView.addArrangedSubview(commitDetailsVStack)
        imageAndTitleStackView.addArrangedSubview(userImageView)
        imageAndTitleStackView.addArrangedSubview(titlesVStack)
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
            make.edges.equalTo(contentView).inset(
                UIEdgeInsets(
                    top: 16,
                    left: 8,
                    bottom: 16,
                    right: 8
                )
            )
        }
        userImageView.snp.makeConstraints { make in
            make.size.equalTo(50)
            userImageView.layer.cornerRadius = 50 * 0.5
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userImageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
    }
    
    func configure(with data: PublicRepositoryListResponse?) {
        userImageView.sd_setImage(
            with: URL(string: data?.owner.avatarUrl ?? "")
        )
        titleLabel.text = data?.owner.login
        subtitleLabel.text = data?.repoName
    }
}
