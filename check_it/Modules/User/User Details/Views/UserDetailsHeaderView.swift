//
//  UserDetailsHeaderView.swift
//  check_it
//
//  Created by Ademola Fadumo on 02/01/2024.
//

import UIKit
import SDWebImage

class UserDetailsHeaderView: UIView {
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.image = Asset.Assets.checkitLogo.image
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let profileTextsVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "[Name here]"
        label.font = FontFamily.NunitoSans7pt.bold.font(size: 16)
        label.textColor = Asset.Colors.ColorScheme.headline.color
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email: marcus.j@example.com"
        label.font = FontFamily.NunitoSans7pt.regular.font(size: 12)
        label.textColor = Asset.Colors.ColorScheme.body.color
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Location: San Francisco, CA."
        label.font = FontFamily.NunitoSans7pt.regular.font(size: 12)
        label.textColor = Asset.Colors.ColorScheme.body.color
        return label
    }()
    
    private let commitCountsLabel: UILabel = {
        let label = UILabel()
        label.text = "30,000 Commits"
        label.font = FontFamily.NunitoSans7pt.semiBold.font(size: 12)
        label.textColor = Asset.Colors.ColorScheme.primary.color
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    private func initializeSubviews() {
        addSubview(userImageView)
        addSubview(profileTextsVStack)
        profileTextsVStack.addArrangedSubview(nameLabel)
        profileTextsVStack.addArrangedSubview(emailLabel)
        profileTextsVStack.addArrangedSubview(locationLabel)
        profileTextsVStack.addArrangedSubview(commitCountsLabel)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyConstraints()
    }
    
    private func applyConstraints() {
        let imageSize = 96.0
        userImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalTo(self)
            make.trailing.equalTo(profileTextsVStack.snp.leading).offset(-20)
            make.size.equalTo(imageSize)
            userImageView.layer.cornerRadius = imageSize * 0.5
        }
        profileTextsVStack.snp.makeConstraints { make in
            make.top.bottom.trailing.equalTo(self)
        }
    }
    
    func configure(with data: PublicRepositoryListResponse) {
        userImageView.sd_setImage(
            with: URL(string: data.owner.avatarUrl )
        )
        nameLabel.text = data.owner.login
    }
}
