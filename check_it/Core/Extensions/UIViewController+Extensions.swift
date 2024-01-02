//
//  UIViewController+Extensions.swift
//  check_it
//
//  Created by Ademola Fadumo on 02/01/2024.
//

import UIKit
import RxSwift

extension UIViewController {
    func showAlert(_ title: String, message: String? = nil) -> Completable {
      return Completable.create { [weak self] completable in
        let alert = UIAlertController(
          title: title,
          message: message,
          preferredStyle: .alert
        )
        alert.addAction(
          UIAlertAction(
            title: "Close",
            style: .default,
            handler: { _ in
              completable(.completed)
            }
          )
        )
        self?.present(alert, animated: true, completion: nil)
        return Disposables.create()
      }
    }
}
