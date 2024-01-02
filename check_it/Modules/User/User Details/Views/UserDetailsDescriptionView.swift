//
//  UserDetailsDescriptionView.swift
//  check_it
//
//  Created by Ademola Fadumo on 02/01/2024.
//

import UIKit

class UserDetailsDescriptionView: UIView {
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
        label.text = "About"
        label.font = FontFamily.NunitoSans7pt.bold.font(size: 14)
        label.textColor = Asset.Colors.ColorScheme.headline.color
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Emily Smith, based in New York City, is a passionate coder specializing in web development. With a focus on crafting user-friendly interfaces, she explores React's potential while actively contributing to open-source projects. Her dedication extends to mentoring and community-driven initiatives, aiming to innovate and solve real-world problems through technology"
        label.font = FontFamily.NunitoSans7pt.regular.font(size: 12)
        label.textColor = Asset.Colors.ColorScheme.body.color
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    private func initializeSubviews() {
        addSubview(containerVStack)
        containerVStack.addArrangedSubview(sectionLabel)
        containerVStack.addArrangedSubview(descriptionLabel)
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
            make.edges.equalTo(self)
        }
    }
    
    func configure(with data: PublicRepositoryListResponse) {
        descriptionLabel.text = data.description
    }
}
