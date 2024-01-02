//
//  AppRouter.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import UIKit

enum Routes: String {
    case splash = "/launch"
    case onboarding = "/onboarding"
    case userList = "/userList"
    case userDetails = "/userDetails"

    var vc: UIViewController {
        switch self {
        case .splash:
            return SplashRouterImpl.route().entry!
        case .onboarding:
            return OnboardingRouterImpl.route().entry!
        case .userList:
            return UserListRouterImpl.route().entry!
        case .userDetails:
            return UserDetailsRouterImpl.route().entry!
        }
    }
}
