//
//  UIColor+Extensions.swift
//  check_it
//
//  Created by Ademola Fadumo on 02/01/2024.
//

import UIKit

extension UIColor {
    func light() -> UIColor {
        return self.resolvedColor(
            with: UITraitCollection(userInterfaceStyle: .light)
        )
    }

    func dark() -> UIColor {
        return self.resolvedColor(
            with: UITraitCollection(userInterfaceStyle: .dark)
        )
    }

    func flipped() -> UIColor {
        return UIColor.init { (trait) -> UIColor in
            if trait.userInterfaceStyle == .dark {
                return self.light()
            }
            return self.dark()
        }
    }
}
