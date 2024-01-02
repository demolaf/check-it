//
//  SplashViewController.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import UIKit
import SnapKit

protocol SplashView: AnyObject {
    var presenter: SplashPresenter? { get set }
}

class SplashViewController: UIViewController, SplashView {
    var presenter: SplashPresenter?
    
    private let logoHStack: UIStackView = {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.spacing = 20
        hStack.translatesAutoresizingMaskIntoConstraints = false
        return hStack
    }()
    
    private let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Assets.checkitLogo.image
        return imageView
    }()
    
    private let appNameLabel: UILabel = {
        let appName = "check it".uppercased()

        let label = UILabel()
        label.text = appName
        label.font = .systemFont(ofSize: 40, weight: .heavy)
        return label
    }()

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
    
    private func initializeViewAppearance() {
        view.backgroundColor = Asset.Colors.ColorScheme.tertiary.color
    }

    private func initializeSubviews() {
        view.addSubview(logoHStack)
        logoHStack.addArrangedSubview(logo)
        logoHStack.addArrangedSubview(appNameLabel)
    }
    
    private func applyConstraints() {
        logoHStack.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
    }
}
