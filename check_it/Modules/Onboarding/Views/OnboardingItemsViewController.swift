//
//  OnboardingItemsViewController.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import UIKit

class OnboardingItemsViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.width.equalTo(imageView.snp.height)
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let textsVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = FontFamily.NunitoSans7pt.bold.font(size: 24)
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = FontFamily.NunitoSans7pt.regular.font(size: 16)
        label.textColor = Asset.Colors.ColorScheme.body.color
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyConstraints()
    }
    
    func configureView(data: OnboardingData) {
        imageView.image = UIImage(named: data.image)
        titleLabel.text = data.title
        subTitleLabel.text = data.subitle
    }
}

extension OnboardingItemsViewController {
    private func initializeSubviews() {
        view.addSubview(imageView)
        view.addSubview(textsVStack)
        textsVStack.addArrangedSubview(titleLabel)
        textsVStack.addArrangedSubview(subTitleLabel)
    }
    
    private func applyConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view).inset(24)
            make.bottom.equalTo(textsVStack.snp.top).offset(-24)
        }
        textsVStack.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(24)
        }
    }
}
