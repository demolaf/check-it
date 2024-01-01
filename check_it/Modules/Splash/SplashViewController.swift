//
//  SplashViewController.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewAppearance()
    }
}

extension SplashViewController {
    private func initializeViewAppearance() {
        view.backgroundColor = Asset.Colors.tertiary.color
    }
}
